import 'package:gtm/pages/manage_trip/bloc/services/service_popup/service_popup_event.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

enum SaveServicePopupState { initial, loading, success, failure }

class SaveServicePopupBloc extends Bloc<ServicePopupEvent, SaveServicePopupState> {
  final TripManagerServiceRepository _tripManagerServiceRepository;

  SaveServicePopupBloc({required TripManagerServiceRepository tripManagerServiceRepository})
      : _tripManagerServiceRepository = tripManagerServiceRepository,
        super(SaveServicePopupState.initial) {
    on<SavePopup>(_savePopup);
  }

  Future<void> _savePopup(
    ServicePopupEvent event,
    Emitter<SaveServicePopupState> emit,
  ) async {
    SavePopup saveServicePopup = event as SavePopup;
    emit(SaveServicePopupState.loading);
    try {
      final isSaved = await _tripManagerServiceRepository.saveServiceModalPopupDetail(
          type: saveServicePopup.type,
          serviceId: saveServicePopup.serviceId,
          tripServiceModalPopupPayload: saveServicePopup.tripServiceModalPopupPayload);
      if (isSaved ?? false) {
        emit(SaveServicePopupState.success);
        return;
      }
      emit(SaveServicePopupState.failure);
    } catch (e) {
      log(e.toString());
      emit(SaveServicePopupState.failure);
    }
  }
}
