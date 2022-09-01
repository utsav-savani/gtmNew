import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:json_annotation/json_annotation.dart';
part 'customer_operational_note.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomerOperationalNote {
  final int customerOperationalNoteId;
  final String note;

  CustomerOperationalNote(
      {required this.customerOperationalNoteId, required this.note});

  static CustomerOperationalNote fromJson(JsonMap json) =>
      _$CustomerOperationalNoteFromJson(json);
  JsonMap toJson() => _$CustomerOperationalNoteToJson(this);
}
