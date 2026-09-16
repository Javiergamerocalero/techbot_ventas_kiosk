import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Bitácora de las operaciones que el kiosco hace contra servicios
/// externos: el pinpad Izipay y la facturación. Guarda el requerimiento y
/// la respuesta de cada una para poder diagnosticar sin estar delante del
/// equipo.
///
/// Pedido por Javier el 2026-09-16, mientras la integración de Izipay
/// seguía sin funcionar contra su backend.
///
/// Dos cuidados que no son negociables:
///
///  - **Nunca se guardan credenciales.** Contraseñas, tokens y llaves se
///    reemplazan por `oculto` antes de escribir nada. Esto queda en el
///    equipo y se copia y pega en WhatsApp.
///  - **El registro no puede tumbar una venta.** Todo lo que hace está
///    envuelto en try/catch: si falla el guardado, la operación sigue.
class AppLog {
  AppLog._();

  static const _clavePrefs = 'app_log_entradas';

  /// Tope de entradas. Cada operación de Izipay son dos (ida y vuelta) y
  /// un día de kiosco no pasa de unas pocas decenas, así que 200 cubre
  /// varios días sin engordar las preferencias.
  static const maximoEntradas = 200;

  /// Recorte por campo. Un voucher entero pasa los 2000 caracteres y no
  /// aporta nada al diagnóstico más allá del principio.
  static const _maximoPorCampo = 4000;

  /// Claves cuyo valor jamás se escribe.
  static const _clavesSensibles = {
    'ecr_password',
    'password',
    'token',
    'authorization',
    'api_key',
    'apikey',
    'secret',
    'client_secret',
    'x-tenant-key',
  };

  /// La lista viva, para que la pantalla se actualice sola.
  static final ValueNotifier<List<AppLogEntry>> entradas =
      ValueNotifier<List<AppLogEntry>>(const []);

  static bool _cargado = false;

  /// Levanta lo guardado. Se llama una vez al arrancar la app.
  static Future<void> cargar() async {
    if (_cargado) return;
    _cargado = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final crudo = prefs.getString(_clavePrefs);
      if (crudo == null || crudo.isEmpty) return;
      final lista = (jsonDecode(crudo) as List)
          .whereType<Map<String, dynamic>>()
          .map(AppLogEntry.fromJson)
          .toList();
      entradas.value = lista;
    } catch (_) {
      // Un registro corrupto no puede impedir que el kiosco arranque.
      entradas.value = const [];
    }
  }

  /// Anota una operación. [request] y [response] admiten mapas, listas o
  /// texto suelto; lo que sea se serializa y se enmascara.
  static void registrar({
    required AppLogCategoria categoria,
    required String operacion,
    Object? request,
    Object? response,
    bool ok = true,
    String? detalle,
    Duration? duracion,
  }) {
    try {
      final entrada = AppLogEntry(
        hora: DateTime.now(),
        categoria: categoria,
        operacion: operacion,
        ok: ok,
        detalle: detalle,
        request: _aTexto(request),
        response: _aTexto(response),
        milisegundos: duracion?.inMilliseconds,
      );
      final nuevas = [entrada, ...entradas.value];
      if (nuevas.length > maximoEntradas) {
        nuevas.removeRange(maximoEntradas, nuevas.length);
      }
      entradas.value = nuevas;
      _guardar(nuevas);
    } catch (_) {
      // Registrar nunca puede romper la operación que se está registrando.
    }
  }

  static Future<void> limpiar() async {
    entradas.value = const [];
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_clavePrefs);
    } catch (_) {}
  }

  /// Todo el registro como texto plano, para copiarlo y mandarlo.
  static String exportarTexto() {
    final b = StringBuffer()
      ..writeln('Registro del kiosco — ${DateTime.now()}')
      ..writeln('${entradas.value.length} operaciones')
      ..writeln();
    for (final e in entradas.value) {
      b
        ..writeln('─' * 40)
        ..writeln('${e.horaCorta}  ${e.categoria.etiqueta}  ${e.operacion}')
        ..writeln('resultado: ${e.ok ? 'OK' : 'FALLÓ'}'
            '${e.milisegundos != null ? '  (${e.milisegundos} ms)' : ''}');
      if (e.detalle != null && e.detalle!.isNotEmpty) {
        b.writeln('detalle: ${e.detalle}');
      }
      if (e.request.isNotEmpty) b.writeln('envío: ${e.request}');
      if (e.response.isNotEmpty) b.writeln('respuesta: ${e.response}');
    }
    return b.toString();
  }

  static Future<void> _guardar(List<AppLogEntry> lista) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _clavePrefs,
        jsonEncode(lista.map((e) => e.toJson()).toList()),
      );
    } catch (_) {}
  }

  static String _aTexto(Object? valor) {
    if (valor == null) return '';
    try {
      final limpio = enmascarar(valor);
      final texto = limpio is String ? limpio : jsonEncode(limpio);
      return texto.length > _maximoPorCampo
          ? '${texto.substring(0, _maximoPorCampo)}… [recortado]'
          : texto;
    } catch (_) {
      return valor.toString();
    }
  }

  /// Reemplaza el valor de toda clave sensible por `oculto`, a cualquier
  /// profundidad. Sobre texto suelto tapa el patrón `Bearer <token>`.
  @visibleForTesting
  static Object? enmascarar(Object? valor) {
    if (valor is Map) {
      return {
        for (final entrada in valor.entries)
          entrada.key.toString():
              _clavesSensibles.contains(entrada.key.toString().toLowerCase())
                  ? 'oculto'
                  : enmascarar(entrada.value),
      };
    }
    if (valor is List) return valor.map(enmascarar).toList();
    if (valor is String) {
      return valor.replaceAll(
        RegExp(r'Bearer\s+[A-Za-z0-9._\-]+', caseSensitive: false),
        'Bearer oculto',
      );
    }
    return valor;
  }
}

enum AppLogCategoria {
  izipay('Izipay'),
  facturacion('Facturación'),
  otros('Otros');

  const AppLogCategoria(this.etiqueta);
  final String etiqueta;

  static AppLogCategoria desdeNombre(String nombre) =>
      AppLogCategoria.values.firstWhere(
        (c) => c.name == nombre,
        orElse: () => AppLogCategoria.otros,
      );
}

class AppLogEntry {
  const AppLogEntry({
    required this.hora,
    required this.categoria,
    required this.operacion,
    required this.ok,
    required this.request,
    required this.response,
    this.detalle,
    this.milisegundos,
  });

  final DateTime hora;
  final AppLogCategoria categoria;
  final String operacion;
  final bool ok;
  final String request;
  final String response;
  final String? detalle;
  final int? milisegundos;

  String get horaCorta {
    String dos(int n) => n.toString().padLeft(2, '0');
    return '${dos(hora.day)}/${dos(hora.month)} '
        '${dos(hora.hour)}:${dos(hora.minute)}:${dos(hora.second)}';
  }

  Map<String, dynamic> toJson() => {
        'hora': hora.toIso8601String(),
        'categoria': categoria.name,
        'operacion': operacion,
        'ok': ok,
        'request': request,
        'response': response,
        if (detalle != null) 'detalle': detalle,
        if (milisegundos != null) 'ms': milisegundos,
      };

  factory AppLogEntry.fromJson(Map<String, dynamic> json) => AppLogEntry(
        hora: DateTime.tryParse(json['hora']?.toString() ?? '') ??
            DateTime.fromMillisecondsSinceEpoch(0),
        categoria: AppLogCategoria.desdeNombre(json['categoria']?.toString() ?? ''),
        operacion: json['operacion']?.toString() ?? '',
        ok: json['ok'] == true,
        request: json['request']?.toString() ?? '',
        response: json['response']?.toString() ?? '',
        detalle: json['detalle']?.toString(),
        milisegundos: json['ms'] is int ? json['ms'] as int : null,
      );
}
