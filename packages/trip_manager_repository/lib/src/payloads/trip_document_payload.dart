import 'package:trip_manager_repository/src/models.dart';

class TripManagerDocumentPayload extends Equatable {
  final String guid;
  final List<Map<String, dynamic>>? stations;
  final List<Map<String, dynamic>>? services;
  final bool excludeCancelled;
  final bool isLocal;
  final bool isUTC;
  final bool isWeather;
  final bool fuelRelease;
  final bool isNOTAMS;

  TripManagerDocumentPayload.initial()
      : this(
          excludeCancelled: false,
          fuelRelease: false,
          guid: '',
          isLocal: false,
          isNOTAMS: false,
          isUTC: false,
          isWeather: false,
        );

  TripManagerDocumentPayload({
    required this.excludeCancelled,
    required this.fuelRelease,
    required this.guid,
    required this.isLocal,
    required this.isNOTAMS,
    required this.isUTC,
    required this.isWeather,
    this.services,
    this.stations,
  });

  Map<String, dynamic> toJson() => {
        "guid": guid,
        "station": stations,
        "services": services,
        "excludeCancelled": excludeCancelled,
        "isLocal": isLocal,
        "isUTC": isUTC,
        "isWeather": isWeather,
        "fuel_release": fuelRelease,
        "isNOTAMS": isNOTAMS,
      };

  @override
  List<Object?> get props => [
        guid,
        stations,
        services,
        excludeCancelled,
        isLocal,
        isUTC,
        isWeather,
        fuelRelease,
        isNOTAMS
      ];
}
