part of 'airport_bloc.dart';

enum FetchAirportStatus { initial, loading, success, failure }

class AirportState extends Equatable {
  final FetchAirportStatus status;
  final List<Airport>? airports;

  const AirportState({
    this.status = FetchAirportStatus.initial,
    this.airports,
  });

  AirportState copyWith({
    FetchAirportStatus? status,
    required List<Airport> airports,
  }) {
    return AirportState(
      status: status ?? this.status,
      airports: airports,
    );
  }

  @override
  List<Object?> get props => [status, airports];
}
