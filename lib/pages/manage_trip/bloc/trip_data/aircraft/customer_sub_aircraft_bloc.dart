import 'dart:developer';

import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/aircraft/customer_sub_aircraft_state.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/aircraft/customer_sub_aricraft_event.dart';

class CustomerSubAircraftBloc extends Bloc<SubAircraftEvent, SubAircraftState> {
  final AircraftRepository _aircraftRepository;

  CustomerSubAircraftBloc({required AircraftRepository aircraftRepository})
      : _aircraftRepository = aircraftRepository,
        super(const SubAircraftState()) {
    on<FetchCustomerSubAircraftData>(_getSubAircraft);
  }

  Future<void> _getSubAircraft(
    SubAircraftEvent event,
    Emitter<SubAircraftState> emit,
  ) async {
    FetchCustomerSubAircraftData aircraftData =
        event as FetchCustomerSubAircraftData;
    if (aircraftData.aircraftID == 0 || aircraftData.customerID == 0) {
      return;
    }
    emit(state.copyWith(status: FetchSubAircraftStatus.loading, aircrafts: []));
    try {
      final aircraft = await _aircraftRepository.getSubAircrafts(
        aircraftId: aircraftData.aircraftID,
        customerId: aircraftData.customerID,
      );
      emit(state.copyWith(
        status: FetchSubAircraftStatus.success,
        aircrafts: aircraft,
      ));
    } catch (e) {
      log(e.toString());
      emit(state
          .copyWith(status: FetchSubAircraftStatus.failure, aircrafts: []));
    }
  }
}
