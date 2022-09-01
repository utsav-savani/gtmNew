import 'package:json_annotation/json_annotation.dart';
import 'package:people_repository/config/typedef_json.dart';

part 'profile_type.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileType {
  final int formId;
  bool isCaptain = false;
  bool isCrew = false;
  bool isOther = false;
  bool isPassenger = false;
  bool isVip = false;

  ProfileType({required this.formId});
  static ProfileType fromJson(JsonMap json) => _$ProfileTypeFromJson(json);
  JsonMap toJson() => _$ProfileTypeToJson(this);
}
