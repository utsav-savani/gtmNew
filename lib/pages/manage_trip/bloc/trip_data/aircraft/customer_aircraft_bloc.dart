

import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/aircraft/customer_aircraft_event.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/aircraft/customer_aircraft_state.dart';

class CustomerAircraftBloc extends Bloc<CustomerAircraftEvent, CustomerAircraftState> {
  final AircraftRepository _aircraftRepository;
  final List<Aircraft> _aircraft = [];

  CustomerAircraftBloc({required AircraftRepository aircraftRepository})
      : _aircraftRepository = aircraftRepository,
        super(const CustomerAircraftState()) {
    on<FetchCustomerAircraftData>(_getAircraft);
  }

  Future<void> _getAircraft(
      CustomerAircraftEvent event,
      Emitter<CustomerAircraftState> emit,
      ) async {
    FetchCustomerAircraftData aircraftData = event as FetchCustomerAircraftData;
    if(aircraftData.customerID==0){
      return;
    }
    emit(state.copyWith(status: FetchCustomerAircraftStatus.loading, aircrafts: []));
    _aircraftRepository.setCustomerId(aircraftData.customerID.toString());
    try {
      final aircraft = await _aircraftRepository.getAircrafts();
      _aircraft.clear();
      _aircraft.addAll(aircraft);
      emit(state.copyWith(
        status: FetchCustomerAircraftStatus.success,
        aircrafts: aircraft,
      ));
    } catch (e) {
      emit(state.copyWith(status: FetchCustomerAircraftStatus.failure, aircrafts: []));
    }
  }

}
