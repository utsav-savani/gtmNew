import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_event.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

enum SavePOBStatus { initial, loading, success, failure }

class SavePOBBloc extends Bloc<POBEvent, SavePOBStatus> {
  final TripManagerPOBRepository _tripManagerPOBRepository;

  SavePOBBloc({required TripManagerPOBRepository tripManagerPOBRepository})
      : _tripManagerPOBRepository = tripManagerPOBRepository,
        super(SavePOBStatus.initial) {
    on<SavePOBScheduleDetails>(_savePOBScheduleDetails);
    on<SavePOBDetails>(_savePOBDetails);
    on<ResetPOBState>(_resetState);
  }

  Future<void> _savePOBScheduleDetails(
    POBEvent event,
    Emitter<SavePOBStatus> emit,
  ) async {
    SavePOBScheduleDetails savePOBScheduleDetails =
        event as SavePOBScheduleDetails;
    emit(SavePOBStatus.loading);
    try {
      final isSaved = await _tripManagerPOBRepository.savePOBScheduleDetails(
          pobScheduleDetails: savePOBScheduleDetails.podScheduleDetails);
      emit(isSaved ? SavePOBStatus.success : SavePOBStatus.failure);
    } catch (e) {
      log(e.toString());
      emit(SavePOBStatus.failure);
    }
  }

  Future<void> _savePOBDetails(
    POBEvent event,
    Emitter<SavePOBStatus> emit,
  ) async {
    SavePOBDetails savePOBDetails = event as SavePOBDetails;
    emit(SavePOBStatus.loading);
    try {
      final isSaved = await _tripManagerPOBRepository.savePOBDetails(
          unknownPersons: savePOBDetails.unknownPersons);
      emit(isSaved ? SavePOBStatus.success : SavePOBStatus.failure);
    } catch (e) {
      log(e.toString());
      emit(SavePOBStatus.failure);
    }
  }

  FutureOr<void> _resetState(ResetPOBState event, Emitter<SavePOBStatus> emit) {
    emit(SavePOBStatus.initial);
  }
}
