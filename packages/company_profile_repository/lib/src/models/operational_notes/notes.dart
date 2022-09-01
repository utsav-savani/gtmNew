import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:company_profile_repository/src/models/operational_notes/customer_operational_note.dart';
import 'package:company_profile_repository/src/models/operational_notes/note_service.dart';
import 'package:json_annotation/json_annotation.dart';
part 'notes.g.dart';

@JsonSerializable(explicitToJson: true)
class Notes {
  final int? operationalNoteId;
  final int customerId;
  final int serviceId;
  @JsonKey(name: 'CustomerHasOperationalNotes')
  final List<CustomerOperationalNote>? customerHasOperationalNotes;
  @JsonKey(name: 'OperationalNotesHasService')
  final NoteService service;
  Notes(
      {this.operationalNoteId,
      required this.customerId,
      required this.serviceId,
      required this.service,
      this.customerHasOperationalNotes});
  static Notes fromJson(JsonMap json) => _$NotesFromJson(json);
  JsonMap toJson() => _$NotesToJson(this);
}
