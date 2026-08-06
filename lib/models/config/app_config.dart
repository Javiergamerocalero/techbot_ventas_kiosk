
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'app_config.freezed.dart';
part 'app_config.g.dart';

@freezed
sealed class AppConfig with _$AppConfig {
  const factory AppConfig({
    required Map<String, dynamic> styles,
    required Map<String, dynamic> layout,
    String? logoUrl,
    Map<String, dynamic>? extras,
  }) = _AppConfig;

  factory AppConfig.fromJson(Map<String, dynamic> json) => _$AppConfigFromJson(json);
}

extension AppConfigJson on AppConfig {
  String toJsonString() => jsonEncode(toJson());
  static AppConfig fromJsonString(String str) => AppConfig.fromJson(jsonDecode(str));
}

