// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BusinessInfo _$BusinessInfoFromJson(Map<String, dynamic> json) =>
    _BusinessInfo(
      businessName: json['business_name'] as String? ?? '',
      tradeName: json['trade_name'] as String? ?? '',
      taxId: json['tax_id'] as String? ?? '',
      address: json['address'] as String? ?? '',
      branchName: json['branch_name'] as String?,
      branchAddress: json['branch_address'] as String?,
    );

Map<String, dynamic> _$BusinessInfoToJson(_BusinessInfo instance) =>
    <String, dynamic>{
      'business_name': instance.businessName,
      'trade_name': instance.tradeName,
      'tax_id': instance.taxId,
      'address': instance.address,
      'branch_name': instance.branchName,
      'branch_address': instance.branchAddress,
    };
