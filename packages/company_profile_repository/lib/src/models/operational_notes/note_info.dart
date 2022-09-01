import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note_info.g.dart';

@JsonSerializable(explicitToJson: true)
class NoteInfo {
  final int serviceId;
  final String note;

  const NoteInfo({required this.serviceId, required this.note});
  static NoteInfo fromJson(JsonMap json) => _$NoteInfoFromJson(json);
  JsonMap toJson() => _$NoteInfoToJson(this);
}
