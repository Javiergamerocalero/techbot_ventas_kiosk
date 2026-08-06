import 'package:freezed_annotation/freezed_annotation.dart';

part 'configuration_data.freezed.dart';
part 'configuration_data.g.dart';

@freezed
sealed class ConfigurationData with _$ConfigurationData {
  const factory ConfigurationData({
    @JsonKey(name: 'apis_net_pe_key') String? apisNetPeKey,
    @JsonKey(name: 'config_password') String? configPassword,
  }) = _ConfigurationData;

  factory ConfigurationData.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationDataFromJson(json);
}
