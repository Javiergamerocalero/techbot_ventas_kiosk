import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

/// Log de sesión de debug. No registrar secretos, tokens ni PII.
void agentDebugLog({
  required String location,
  required String message,
  required String hypothesisId,
  Map<String, Object?> data = const {},
  String runId = 'pre-fix',
}) {
  final payload = jsonEncode({
    'sessionId': '36b1ef',
    'runId': runId,
    'hypothesisId': hypothesisId,
    'location': location,
    'message': message,
    'data': data,
    'timestamp': DateTime.now().millisecondsSinceEpoch,
  });
  // #region agent log
  try {
    File(r'C:\Users\USER\.cursor\projects\C-Users-USER-AppData-Local-Temp-86434ba2-8643-43c0-9b96-968c4fb938cd\debug-36b1ef.log')
        .writeAsStringSync('$payload\n', mode: FileMode.append, flush: true);
  } catch (_) {}
  http
      .post(
        Uri.parse(
          'http://127.0.0.1:7618/ingest/f8a32003-9e28-41e2-b812-b8abb90037fe',
        ),
        headers: {
          'Content-Type': 'application/json',
          'X-Debug-Session-Id': '36b1ef',
        },
        body: payload,
      )
      .ignore();
  // #endregion
}
