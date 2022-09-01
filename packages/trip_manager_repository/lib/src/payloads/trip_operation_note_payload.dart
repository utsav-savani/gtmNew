import 'package:trip_manager_repository/json/json_convertible.dart';

class TripOperationalNotePayload implements JSONConvertible {
  final guid;
  final category;
  final tripCustomerOperationalNoteId;
  final customerOperationalNoteId;
  final note;
  final creatorId;
  final createdAt;

  TripOperationalNotePayload({
    this.note,
    this.guid,
    this.category,
    this.tripCustomerOperationalNoteId,
    this.customerOperationalNoteId,
    this.creatorId,
    this.createdAt,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "guid": guid,
      "category": category,
      "tripCustomerOperationalNoteId": tripCustomerOperationalNoteId,
      "customerOperationalNoteId": customerOperationalNoteId,
      "note": note,
      "creatorId": creatorId,
      "createdAt": createdAt,
    };
  }
}
