import 'package:aircraft_repository/config/typedef_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aircraft_trips.g.dart';

@JsonSerializable(explicitToJson: true)
class AircraftTrips {
  final String acType;
  final int aircraftId;
  final int aircraftTypeId;
  final String? callsign;
  final String? customer;
  final int? customerId;
  final String? fileStatus;
  final int tripId;
  final String tripNumber;
  final String? tripStatus;
  final List<String>? route;
  final int? operatorId;
  final String? operator;
  final String? regNo;
  final String flightCategory;
  final String? start;
  final String? end;

  AircraftTrips(
      {required this.acType,
      required this.aircraftId,
      required this.aircraftTypeId,
      this.callsign,
      this.customer,
      this.customerId,
      this.fileStatus,
      required this.tripId,
      required this.tripNumber,
      this.tripStatus,
      this.route,
      this.operatorId,
      this.operator,
      this.regNo,
      required this.flightCategory,
      this.start,
      this.end});

  static AircraftTrips fromJson(JsonMap json) => _$AircraftTripsFromJson(json);
  JsonMap toJson() => _$AircraftTripsToJson(this);
}
