import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_details/pob_details_state.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_event.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class POBDetailBloc extends Bloc<POBEvent, POBDetailsState> {
  final TripManagerPOBRepository _tripManagerPOBRepository;

  POBDetailBloc({required TripManagerPOBRepository tripManagerPOBRepository})
      : _tripManagerPOBRepository = tripManagerPOBRepository,
        super(const POBDetailsState()) {
    on<FetchPOBDetails>(_getPobDetails);
  }

  Future<void> _getPobDetails(
    POBEvent event,
    Emitter<POBDetailsState> emit,
  ) async {
    FetchPOBDetails fetchPOBDetails = event as FetchPOBDetails;
    emit(state.copyWith(status: FetchPOBDetailsState.loading, pobDetail: const TripPobDetail()));
    try {
      final pobDetail = await _tripManagerPOBRepository.getTripPOBDetails(personId: fetchPOBDetails.personID);
      emit(state.copyWith(status: FetchPOBDetailsState.success, pobDetail: pobDetail ?? const TripPobDetail()));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: FetchPOBDetailsState.failure, pobDetail: const TripPobDetail()));
    }
  }

}
