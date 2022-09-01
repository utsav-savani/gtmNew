import 'package:json_annotation/json_annotation.dart';
import 'package:people_repository/config/typedef_json.dart';
part 'add_contact.g.dart';

@JsonSerializable(explicitToJson: true)
class AddContact {
  final List<String>? email;
  final List<String>? mobile;
  final List<String>? phone;

  const AddContact({this.email, this.mobile, this.phone});

  static AddContact fromJson(JsonMap json) => _$AddContactFromJson(json);
  JsonMap toJson() => _$AddContactToJson(this);
}
