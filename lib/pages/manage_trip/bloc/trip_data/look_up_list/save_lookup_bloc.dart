import 'package:gtm/pages/manage_trip/bloc/trip_data/look_up_list/lookup_event.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/look_up_list/lookup_state.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

enum SaveLookupState { initial, loading, success, failure }

class SaveLookupBloc extends Bloc<LookupEvent, SaveLookupState> {
  final TripManagerRepository _tripMangerRepository;

  SaveLookupBloc({required TripManagerRepository tripMangerRepository})
      : _tripMangerRepository = tripMangerRepository,
        super(SaveLookupState.initial) {
    on<SaveLookupData>(_saveLookUpData);
  }


  Future<void> _saveLookUpData(
      LookupEvent event,
      Emitter<SaveLookupState> emit,
      ) async {
    SaveLookupData saveLookupData = event as SaveLookupData;
    if(saveLookupData.tripLookUpPayload.guid.isEmpty){
      return;
    }
    emit(SaveLookupState.loading);
    try {
      final isSaved = await _tripMangerRepository.saveLookUpData(saveLookupData.tripLookUpPayload);
      if(isSaved){
        emit(SaveLookupState.success);
        return;
      }
      emit(SaveLookupState.failure);
    } catch (e) {
      log(e.toString());
      emit(SaveLookupState.failure);
    }
  }
}
