# ventas_kiosko

Kiosco de ventas Flutter (Qapp). Despliegue actual: San Fernando, tenant 20.

## Izipay — PinPad P400 vía PMP-API REST

El terminal no se maneja por SDK: corre su propio servidor REST (PMP-API) en
un equipo Windows de la LAN. La app lo configura en **Config → Izipay** (IP,
puerto, usuario, contraseña, "Con BIN") y habla con tres rutas bajo
`http://<ip>:<puerto>/API_PPAD/`:

| Ruta | Para qué |
|---|---|
| `POST /login` | Devuelve el JWT. Se cachea y se renueva ante 401/403. |
| `POST /test` | Disponibilidad. `response_code` `00` = listo. |
| `POST /procesarTransaccion` | Todas las operaciones. |

### Qué datos exige cada operación

Esto es lo que rompió el Duplicado el 2026-09-14: el pinpad respondió
**"MONEDA NO EXISTE"** porque el cuerpo viajaba sin `ecr_currency_code`. La
moneda va en **todas** las operaciones, incluso en las que no mueven dinero.

| Operación | `ecr_transaccion` | `ecr_amount` | `ecr_currency_code` | `ecr_data_adicional` |
|---|---|---|---|---|
| Compra | `01` | sí | sí | — |
| Anulación | `06` | sí | sí | referencia de la compra original |
| Reporte detallado | `09` | — | sí | sí (vacío) |
| Reporte de totales | `10` | — | sí | sí (vacío) |
| Reimpresión (Duplicado) | `11` | — | sí | referencia, o vacío para la última |
| Cierre de lote | `12` | — | sí | — |

`ecr_aplicacion` es `POS` siempre. `ecr_currency_code` es `604` (soles);
dólares sería `840`. El monto se serializa con los dos últimos dígitos como
decimales: `S/ 12.34` → `"1234"`, `S/ 0.10` → `"010"`.

Los cuerpos se arman en un solo lugar, `IzipayService.purchaseBody`,
`voidBody` y `supervisorBody`, y hay pruebas que verifican operación por
operación que ninguna salga sin moneda.

**Procedencia de los códigos**: `01` y `06` están verificados contra el
pinpad en producción. Los de supervisor vienen de integraciones públicas de
esta misma PMP-API y de la documentación de EMVKIT Perú, no del manual
oficial de Izipay. Si el manual indica otros, se cambian en las constantes
`txReimpresion`, `txReporteDetallado`, `txReporteTotales` y `txCierre` de
`lib/services/izipay_service.dart`.

### Compra "Con BIN"

Con el interruptor activo la compra son dos llamadas: la primera con
`ecr_data_adicional3: "1"` devuelve el BIN sin cobrar, y la segunda, sin ese
campo, cobra de verdad. Si el cliente cancela entre una y otra se manda
`"9"` para que el pinpad libere el estado. El máximo entre ambas es 120 s.

## Catálogo: el prefijo `PUB`

El kiosco solo lista los productos cuyo SKU empieza con `PUB` (mismo
criterio que DeliBakery). Los demás siguen existiendo y **se agregan
escaneando su código de barras**, que es justamente para lo que sirve el
escáner del mostrador.

Un tenant sin ningún SKU marcado se queda con el menú vacío. Para eso está
**Config → Catálogo → "Mostrar todos los productos"**: apaga el filtro en ese
equipo mientras se marcan los productos en Qapp. Arranca apagado y se guarda
por dispositivo.
