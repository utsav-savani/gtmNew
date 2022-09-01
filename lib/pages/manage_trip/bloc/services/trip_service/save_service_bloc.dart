import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_event.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

enum SaveServiceState { initial, loading, success, failure }

class SaveServiceBloc extends Bloc<TripServiceEvent, SaveServiceState> {
  final TripManagerServiceRepository _tripManagerServiceRepository;

  SaveServiceBloc({required TripManagerServiceRepository tripManagerServiceRepository})
      : _tripManagerServiceRepository = tripManagerServiceRepository,
        super(SaveServiceState.initial) {
    on<SaveService>(_savePopup);
  }

  Future<void> _savePopup(
    TripServiceEvent event,
    Emitter<SaveServiceState> emit,
  ) async {
    SaveService saveService = event as SaveService;
    emit(SaveServiceState.loading);
    try {
      final isSaved = await _tripManagerServiceRepository.saveTripService(
          flightCategoryId: saveService.flightCategoryId, guid: saveService.guid, tripServiceSchedulePayload: saveService.tripServiceSchedulePayload);
      if (isSaved ?? false) {
        emit(SaveServiceState.success);
        return;
      }
      emit(SaveServiceState.failure);
    } catch (e) {
      log(e.toString());
      emit(SaveServiceState.failure);
    }
  }
}
