import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:company_profile_repository/src/models/operational_notes/note_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_note.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateNote {
  final int customerId;
  @JsonKey(name: 'Customernoteinfo')
  final List<NoteInfo> customerNoteInfo;
  const CreateNote({required this.customerId, required this.customerNoteInfo});

  static CreateNote fromJson(JsonMap json) => _$CreateNoteFromJson(json);
  JsonMap toJson() => _$CreateNoteToJson(this);
}
