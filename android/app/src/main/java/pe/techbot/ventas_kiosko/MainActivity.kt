package pe.techbot.ventas_kiosko

import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.hardware.usb.*
import android.os.Build
import android.os.Bundle
import android.os.Parcelable
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

// Helper extension function for getParcelableExtra compatibility
inline fun <reified T : Parcelable> Intent.getParcelableExtraCompat(key: String): T? {
    return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
        getParcelableExtra(key, T::class.java)
    } else {
        @Suppress("DEPRECATION")
        getParcelableExtra(key) as? T
    }
}

class MainActivity : FlutterActivity() {
    private val tag = "MainActivity"

    // Channel and Method/Argument Constants
    private val channelName = "usb_printer_channel"
    private val actionUsbPermission = "pe.techbot.ventas_kiosko.USB_PERMISSION"

    private val methodGetUsbDevices = "getUsbDevices"
    private val methodConnectToDevice = "connectToDevice"
    private val methodSendData = "sendData"
    private val methodDisconnectDevice = "disconnectDevice"

    private val argVendorId = "vendorId"
    private val argProductId = "productId"
    private val argData = "data"

    // USB and State Variables
    private lateinit var usbManager: UsbManager
    private lateinit var permissionIntent: PendingIntent
    private var device: UsbDevice? = null
    private var usbInterface: UsbInterface? = null
    private var endpoint: UsbEndpoint? = null
    private var connection: UsbDeviceConnection? = null

    private var connectResult: MethodChannel.Result? = null // To hold the result for the async permission request

    private val usbReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent) {
            val action = intent.action
            if (actionUsbPermission == action) {
                synchronized(this) {
                    val usbDevice: UsbDevice? = intent.getParcelableExtraCompat(UsbManager.EXTRA_DEVICE)
                    if (intent.getBooleanExtra(UsbManager.EXTRA_PERMISSION_GRANTED, false)) {
                        if (usbDevice != null && connectResult != null) {
                            Log.d(tag, "Permission granted for device " + usbDevice.deviceName)
                            openDevice(usbDevice)
                            if (connection != null) {
                                connectResult?.success("Permission granted and device opened.")
                            } else {
                                connectResult?.error("CONNECTION_FAILED", "Failed to open device connection.", null)
                            }
                        }
                    } else {
                        Log.w(tag, "Permission denied for device.")
                        connectResult?.error("PERMISSION_DENIED", "User denied USB permission.", null)
                    }
                    connectResult = null // Reset the result callback
                }
            }

            if (UsbManager.ACTION_USB_DEVICE_DETACHED == action) {
                val detachedDevice: UsbDevice? = intent.getParcelableExtraCompat(UsbManager.EXTRA_DEVICE)
                if (detachedDevice != null && device != null && detachedDevice.vendorId == device!!.vendorId && detachedDevice.productId == device!!.productId) {
                    Log.i(tag, "Connected printer detached. Closing connection.")
                    closeConnection()
                }
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        usbManager = getSystemService(USB_SERVICE) as UsbManager
        val intent = Intent(actionUsbPermission)
        val pendingIntentFlags =
            PendingIntent.FLAG_IMMUTABLE
        permissionIntent = PendingIntent.getBroadcast(this, 0, intent, pendingIntentFlags)

        val filter = IntentFilter(actionUsbPermission)
        filter.addAction(UsbManager.ACTION_USB_DEVICE_DETACHED)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            registerReceiver(usbReceiver, filter, RECEIVER_NOT_EXPORTED)
        } else {
            @Suppress("UnspecifiedRegisterReceiverFlag")
            registerReceiver(usbReceiver, filter)
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        unregisterReceiver(usbReceiver)
        closeConnection()
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    methodGetUsbDevices -> result.success(getUsbDevices())
                    methodConnectToDevice -> {
                        val localResult: MethodChannel.Result = result
                        connectResult = localResult

                        val deviceToConnect = getUsbDevice(call.arguments)
                        if (deviceToConnect == null) {
                            localResult.error("DEVICE_NOT_FOUND", "Device not found", null)
                            connectResult = null
                            return@setMethodCallHandler
                        }

                        if (usbManager.hasPermission(deviceToConnect)) {
                            openDevice(deviceToConnect)
                            if (connection != null) {
                                localResult.success("Device already had permission and was opened.")
                            } else {
                                localResult.error("CONNECTION_FAILED", "Failed to open device connection.", null)
                            }
                            connectResult = null
                        } else {
                            usbManager.requestPermission(deviceToConnect, permissionIntent)
                        }
                    }
                    methodSendData -> {
                        val data: ByteArray? = call.argument(argData)
                        if (connection == null || endpoint == null) {
                            result.error("NOT_CONNECTED", "Device is not connected or endpoint not found.", null)
                            return@setMethodCallHandler
                        }
                        if (data == null) {
                            result.error("INVALID_ARGUMENT", "Data to send cannot be null.", null)
                            return@setMethodCallHandler
                        }
                        sendData(data, result)
                    }
                    methodDisconnectDevice -> {
                        closeConnection()
                        result.success("Device disconnected successfully.")
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun getUsbDevice(arguments: Any?): UsbDevice? {
        val args = arguments as? Map<*, *>
        val vendorId = args?.get(argVendorId) as? Int
        val productId = args?.get(argProductId) as? Int

        if (vendorId == null || productId == null) {
            return null
        }

        return usbManager.deviceList.values.find { it.vendorId == vendorId && it.productId == productId }
    }

    private fun getUsbDevices(): List<Map<String, Any?>> {
        return usbManager.deviceList.values.map {
            mapOf(
                "deviceId" to it.deviceId,
                argVendorId to it.vendorId,
                argProductId to it.productId,
                "productName" to it.productName,
                "deviceName" to it.deviceName,
                "deviceClass" to it.deviceClass
            )
        }
    }

    private fun openDevice(device: UsbDevice) {
        // Always close any existing connection before opening a new one.
        closeConnection()

        this.device = device
        connection = usbManager.openDevice(device)
        if (connection == null) {
            Log.e(tag, "Failed to open device connection.")
            return
        }

        for (i in 0 until device.interfaceCount) {
            val iface = device.getInterface(i)
            if (iface.interfaceClass == UsbConstants.USB_CLASS_PRINTER) {
                usbInterface = iface
                for (j in 0 until iface.endpointCount) {
                    val ep = iface.getEndpoint(j)
                    if (ep.type == UsbConstants.USB_ENDPOINT_XFER_BULK && ep.direction == UsbConstants.USB_DIR_OUT) {
                        endpoint = ep
                        break
                    }
                }
                break
            }
        }

        if (usbInterface != null && endpoint != null) {
            if (connection?.claimInterface(usbInterface, true) == false) {
                Log.e(tag, "Failed to claim interface.")
                closeConnection()
            }
        } else {
            Log.e(tag, "Printer interface or endpoint not found.")
            closeConnection()
        }
    }

    private fun sendData(data: ByteArray, result: MethodChannel.Result) {
        if (connection == null || endpoint == null) {
            result.error("CONNECTION_ERROR", "Connection or endpoint is null.", null)
            return
        }

        val timeout = 5000
        val bytesSent = connection?.bulkTransfer(endpoint, data, data.size, timeout)

        if (bytesSent != null && bytesSent < 0) {
            result.error("SEND_ERROR", "Failed to send data to USB device.", null)
        } else {
            result.success(bytesSent)
        }
    }

    private fun closeConnection() {
        connection?.let {
            usbInterface?.let { iface ->
                it.releaseInterface(iface)
            }
            it.close()
            Log.i(tag, "USB connection closed.")
        }
        connection = null
        endpoint = null
        usbInterface = null
        device = null
    }
}
