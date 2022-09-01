import 'package:json_annotation/json_annotation.dart';
import 'package:people_repository/config/typedef_json.dart';

part 'person_contact.g.dart';

@JsonSerializable(explicitToJson: true)
class PersonContact {
  String? mobile;
  String? email;
  String? phone;

  static PersonContact fromJson(JsonMap json) => _$PersonContactFromJson(json);
  JsonMap toJson() => _$PersonContactToJson(this);
}
