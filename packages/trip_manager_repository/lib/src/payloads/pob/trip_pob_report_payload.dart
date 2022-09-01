import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripPOBReportPayload {
  String? tripNumber;
  String? type;
  String? flightDate;
  String? regNo;
  String? flightNumber;
  String? fbo;
  String? arrival;
  String? eTA;
  String? aircraftType;
  String? via;
  String? departure;
  String? departureGen;
  String? destination;
  String? destinationGen;
  String? serial;
  String? color;
  String? operator;
  List<TripPOBReportPeoplePayload> captains;
  List<TripPOBReportPeoplePayload> crew;
  List<TripPOBReportPeoplePayload> passenger;
  TripPobOffice? office;

  TripPOBReportPayload({
    this.tripNumber,
    this.type,
    this.flightDate,
    this.regNo,
    this.flightNumber,
    this.fbo,
    this.arrival,
    this.eTA,
    this.aircraftType,
    this.via,
    this.departure,
    this.departureGen,
    this.destination,
    this.destinationGen,
    this.serial,
    this.color,
    this.operator,
    this.captains = const [],
    this.crew = const [],
    this.passenger = const [],
    this.office,
  });

  Map<String, dynamic> toJson() => {
        "tripNumber": tripNumber,
        "type": type,
        "flightDate": flightDate,
        "regNo": regNo,
        "flightNumber": flightNumber,
        "fbo": fbo,
        "arrival": arrival,
        "ETA": eTA,
        "aircraftType": aircraftType,
        "via": via,
        "departure": departure,
        "departureGen": departureGen,
        "destination": destination,
        "destinationGen": destinationGen,
        "serial": serial,
        "color": color,
        "operator": operator,
        "captain": captains.map((e) => e.toJson()).toList(),
        "crews": crew.map((e) => e.toJson()).toList(),
        "passengers": passenger.map((e) => e.toJson()).toList(),
        "tripOffice": office!.toJson(),
      };
}
