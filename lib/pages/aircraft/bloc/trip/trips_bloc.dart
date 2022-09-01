import 'dart:async';

import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'trips_event.dart';
part 'trips_state.dart';

class TripsBloc extends Bloc<TripsEvent, TripsState> {
  final AircraftRepository _aircraftRepository;
  TripsBloc({required AircraftRepository aircraftRepository})
      : _aircraftRepository = aircraftRepository,
        super(TripsInitial(status: TripListStatus.inital)) {
    on<FetchTripList>(_fetchTripList);
  }

  FutureOr<void> _fetchTripList(
      FetchTripList event, Emitter<TripsState> emit) async {
    try {
      emit(TripsState(
          status: TripListStatus.loading, aircraftTrips: state.aircraftTrips));
      final res = await _aircraftRepository.getAircraftTrips(
          aircraftId: event.aircraftId, page: event.page);
      emit(TripsState(status: TripListStatus.success, aircraftTrips: res));
    } catch (e) {
      emit(TripsState(
          status: TripListStatus.success, aircraftTrips: state.aircraftTrips));
    }
  }
}
