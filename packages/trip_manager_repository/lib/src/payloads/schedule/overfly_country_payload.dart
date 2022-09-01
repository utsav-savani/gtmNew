import 'package:trip_manager_repository/json/json_convertible.dart';

class OverflowCountryPayload implements JSONConvertible {
  final tripOverflyId;
  final tripScheduleId;
  final overflyCountry;
  final sequenceNum;
  final entryPoint;
  final exitPoint;
  final code;
  final archived;
  final countryId;

  OverflowCountryPayload({
    this.archived,
    this.code,
    this.countryId,
    this.entryPoint,
    this.exitPoint,
    this.overflyCountry,
    this.sequenceNum,
    this.tripOverflyId,
    this.tripScheduleId,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "tripOverflyId": tripOverflyId,
      "tripScheduleId": tripScheduleId,
      "overflyCountry": overflyCountry,
      "sequenceNum": sequenceNum,
      "EntryPoint": entryPoint,
      "ExitPoint": exitPoint,
      "code": code,
      "archived": archived,
      "countryId": countryId,
    };
  }
}
