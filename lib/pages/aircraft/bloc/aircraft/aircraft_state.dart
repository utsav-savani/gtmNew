part of 'aircraft_bloc.dart';

enum FetchAircraftsStatus { initial, loading, success, failure }

enum FetchAircraftDetailStatus { initial, loading, success, failure }

class AircraftState extends Equatable {
  final FetchAircraftsStatus status;
  final List<AircraftDetails>? aircraftDetails;
  final List<Aircraft>? aircrafts;

  const AircraftState({
    this.status = FetchAircraftsStatus.initial,
    this.aircrafts,
    this.aircraftDetails,
  });

  AircraftState copyWith({
    FetchAircraftsStatus? status,
    List<AircraftDetails>? aircraftDetails,
    List<Aircraft>? aircrafts,
  }) {
    return AircraftState(
        status: status ?? this.status,
        aircrafts: aircrafts,
        aircraftDetails: aircraftDetails);
  }

  @override
  List<Object?> get props => [status, aircrafts];
}
