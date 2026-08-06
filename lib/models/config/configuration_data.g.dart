// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConfigurationData _$ConfigurationDataFromJson(Map<String, dynamic> json) =>
    _ConfigurationData(
      apisNetPeKey: json['apis_net_pe_key'] as String?,
      configPassword: json['config_password'] as String?,
    );

Map<String, dynamic> _$ConfigurationDataToJson(_ConfigurationData instance) =>
    <String, dynamic>{
      'apis_net_pe_key': instance.apisNetPeKey,
      'config_password': instance.configPassword,
    };
