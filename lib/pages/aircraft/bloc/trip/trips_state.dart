part of 'trips_bloc.dart';

enum TripListStatus { inital, loading, success, failure }

class TripsState extends Equatable {
  final TripListStatus status;
  final List<AircraftTrips> aircraftTrips;
  const TripsState({
    required this.status,
    required this.aircraftTrips,
  });

  @override
  List<Object> get props => [status, aircraftTrips];
}

class TripsInitial extends TripsState {
  TripsInitial({required TripListStatus status})
      : super(status: status, aircraftTrips: []);
}
