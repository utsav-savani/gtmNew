import 'package:trip_manager_repository/json/json_convertible.dart';

class TripManagerPayload implements JSONConvertible {
  final guid;
  final subAircrafts;
  final officeId;
  final customerId;
  final flightCategoryId;
  final aircraftId;
  final operatorId;
  final customerReference;
  final linemode;
  final creatorId;
  final tripCostEstimate;

  const TripManagerPayload({
    this.guid,
    this.aircraftId,
    this.subAircrafts,
    this.officeId,
    this.customerId,
    this.flightCategoryId,
    this.operatorId,
    this.customerReference,
    this.linemode,
    this.creatorId,
    this.tripCostEstimate,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "guid": guid,
      "subAircrafts": subAircrafts,
      "officeId": officeId,
      "customerId": customerId,
      "flightCategoryId": flightCategoryId,
      "aircraftId": aircraftId,
      "operatorId": operatorId,
      "customerReference": customerReference,
      "linemode": linemode,
      "tripStatus": "Draft",
      "creatorId": creatorId,
      "tripCostEstimate": tripCostEstimate,
    };
  }
}
