import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:company_profile_repository/src/models/contacts/contactCategoryInfo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contactTypeInfo.g.dart';

@JsonSerializable(explicitToJson: true)
class ContactTypeInfo {
  final int contactcategorycontentId;
  final int customercontactTypeId;
  final int contactCategoryId;
  final String content;
  @JsonKey(name: 'ContactCategoryInfo')
  final ContactCategoryInfo contactCategoryInfo;

  ContactTypeInfo(this.contactcategorycontentId, this.customercontactTypeId,
      this.contactCategoryId, this.content, this.contactCategoryInfo);

  static ContactTypeInfo fromJson(JsonMap json) =>
      _$ContactTypeInfoFromJson(json);
  JsonMap toJson() => _$ContactTypeInfoToJson(this);
}
