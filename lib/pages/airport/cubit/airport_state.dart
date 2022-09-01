part of 'airport_cubit.dart';

enum FetchAirportStatus { initial, loading, success, failure, paginationsuccess, paginationfailure }

class AirportState extends Equatable {
  final FetchAirportStatus status;
  final List<Airport>? airports;
  final AirportGeneralInfo? airportGeneralInfo;

  const AirportState({
    this.status = FetchAirportStatus.initial,
    this.airports,
    this.airportGeneralInfo,
  });

  AirportState copyWith({
    FetchAirportStatus? status,
    AirportGeneralInfo? airportGeneralInfo,
    required List<Airport> airports,
  }) {
    return AirportState(
      status: status ?? this.status,
      airports: airports,
      airportGeneralInfo: airportGeneralInfo,
    );
  }

  @override
  List<Object?> get props => [status, airports, airportGeneralInfo];
}
