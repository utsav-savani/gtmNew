part of 'paginated_airport_bloc.dart';

enum FetchAirportStatus { initial, loading, success, failure }

class PaginatedAirportState extends Equatable {
  final FetchAirportStatus status;
  final AirportData? airportData;

  const PaginatedAirportState({
    this.status = FetchAirportStatus.initial,
    this.airportData,
  });

  PaginatedAirportState copyWith({
    FetchAirportStatus? status,
    required AirportData airports,
  }) {
    return PaginatedAirportState(
      status: status ?? this.status,
      airportData: airports,
    );
  }

  @override
  List<Object?> get props => [status, airportData];
}
