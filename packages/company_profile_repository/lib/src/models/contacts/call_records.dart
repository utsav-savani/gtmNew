import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'call_records.g.dart';

@JsonSerializable(explicitToJson: true)
class CallRecord {
  final int contactCategoryId;
  @JsonKey(name: 'CustomerContactId')
  final int customerContactId;
  @JsonKey(name: 'CustomerContactTypeId')
  final int customerContactTypeId;
  @JsonKey(name: 'Contact Type')
  final String contactType;
  @JsonKey(name: 'Medium')
  final String medium;
  @JsonKey(name: 'Info')
  final String info;
  @JsonKey(name: 'Purpose')
  final List<String>? purpose;

  CallRecord(
      this.contactCategoryId,
      this.customerContactId,
      this.customerContactTypeId,
      this.contactType,
      this.medium,
      this.info,
      this.purpose);

  static CallRecord fromJson(JsonMap json) => _$CallRecordFromJson(json);
  JsonMap toJson() => _$CallRecordToJson(this);
}
