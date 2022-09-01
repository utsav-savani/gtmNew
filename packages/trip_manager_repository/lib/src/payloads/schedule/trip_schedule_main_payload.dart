import 'package:trip_manager_repository/json/json_convertible.dart';

class TripScheduleMainPayload implements JSONConvertible {
  final tripSchedule;
  final deletedScheduleId;
  final newlyDeletedSchedule;
  final guid;
  final deletedOverflyId;

  TripScheduleMainPayload({
    this.tripSchedule,
    this.deletedScheduleId,
    this.newlyDeletedSchedule,
    this.guid,
    this.deletedOverflyId,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "tripSchedule": tripSchedule,
      "deletedScheduleId": deletedScheduleId,
      "newlyDeletedSchedule": newlyDeletedSchedule,
      "deletedOverflyId": deletedOverflyId,
      "guid": guid,
    };
  }
}
