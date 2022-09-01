import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:company_profile_repository/src/models/contacts/contact_category.dart';
import 'package:json_annotation/json_annotation.dart';
part 'contact_info.g.dart';

@JsonSerializable(explicitToJson: true)
class ContactInfo {
  @JsonKey(name: 'Purposes')
  List<String>? purposes;
  List<ContactCategory>? category;
  String? medium;

  ContactInfo({this.purposes, this.category, this.medium});

  static ContactInfo fromJson(JsonMap json) => _$ContactInfoFromJson(json);
  JsonMap toJson() => _$ContactInfoToJson(this);
}
