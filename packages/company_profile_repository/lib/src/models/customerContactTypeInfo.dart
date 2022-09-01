import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:company_profile_repository/src/models/contacts/contactTypeInfo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customerContactTypeInfo.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomerContactTypeInfo {
  final int customercontactTypeId;
  final int customercontactId;
  @JsonKey(name: 'ContactTypeInfo')
  final List<ContactTypeInfo> contactTypeInfo;

  CustomerContactTypeInfo(
      this.customercontactTypeId, this.customercontactId, this.contactTypeInfo);

  static CustomerContactTypeInfo fromJson(JsonMap json) =>
      _$CustomerContactTypeInfoFromJson(json);
  JsonMap toJson() => _$CustomerContactTypeInfoToJson(this);
}
