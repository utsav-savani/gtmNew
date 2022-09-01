import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contactCategoryInfo.g.dart';

@JsonSerializable(explicitToJson: true)
class ContactCategoryInfo {
  final int contactCategoryId;
  @JsonKey(name: 'Category')
  final String category;

  ContactCategoryInfo(this.contactCategoryId, this.category);

  static ContactCategoryInfo fromJson(JsonMap json) =>
      _$ContactCategoryInfoFromJson(json);
  JsonMap toJson() => _$ContactCategoryInfoToJson(this);
}
