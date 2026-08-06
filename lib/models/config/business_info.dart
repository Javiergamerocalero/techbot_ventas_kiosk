import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_info.freezed.dart';
part 'business_info.g.dart';

@freezed
abstract class BusinessInfo with _$BusinessInfo {
  const factory BusinessInfo({
    @JsonKey(name: 'business_name') @Default('') String businessName,
    @JsonKey(name: 'trade_name') @Default('') String tradeName,
    @JsonKey(name: 'tax_id') @Default('') String taxId,
    @Default('') String address,
    @JsonKey(name: 'branch_name') String? branchName,
    @JsonKey(name: 'branch_address') String? branchAddress,
  }) = _BusinessInfo;

  factory BusinessInfo.fromJson(Map<String, dynamic> json) =>
      _$BusinessInfoFromJson(json);
}
