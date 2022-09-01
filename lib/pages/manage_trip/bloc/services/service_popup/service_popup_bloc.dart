import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/service_popup/service_popup_event.dart';
import 'package:gtm/pages/manage_trip/bloc/services/service_popup/service_popup_state.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class ServicePopupBloc extends Bloc<ServicePopupEvent, ServicePopupState> {
  final TripManagerServiceRepository _tripManagerServiceRepository;

  ServicePopupBloc({required TripManagerServiceRepository tripManagerServiceRepository})
      : _tripManagerServiceRepository = tripManagerServiceRepository,
        super(const ServicePopupState()) {
    on<FetchTripPopup>(_getTripPopupDetails);
  }

  Future<void> _getTripPopupDetails(
    ServicePopupEvent event,
    Emitter<ServicePopupState> emit,
  ) async {
    FetchTripPopup fetchTripPopup = event as FetchTripPopup;
    if (fetchTripPopup.typeId == 0) {
      return;
    }
    emit(state.copyWith(status: FetchSchedulePopupStatus.loading, tripPopupDetail: const TripModalPopupDetail()));
    try {
      final tripPopupDetail =
          await _tripManagerServiceRepository.getTripServiceDetailedModalPopup(type: fetchTripPopup.type, typeId: fetchTripPopup.typeId);
      emit(state.copyWith(
        status: FetchSchedulePopupStatus.success,
        tripPopupDetail: tripPopupDetail ?? const TripModalPopupDetail(),
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: FetchSchedulePopupStatus.failure, tripPopupDetail: const TripModalPopupDetail()));
    }
  }
}
