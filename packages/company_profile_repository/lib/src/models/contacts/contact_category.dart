import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_category.g.dart';

@JsonSerializable(explicitToJson: true)
class ContactCategory {
  final int contactcategoryType;
  List<String>? content;

  ContactCategory({required this.contactcategoryType, required this.content});

  static ContactCategory fromJson(JsonMap json) =>
      _$ContactCategoryFromJson(json);
  JsonMap toJson() => _$ContactCategoryToJson(this);
}
