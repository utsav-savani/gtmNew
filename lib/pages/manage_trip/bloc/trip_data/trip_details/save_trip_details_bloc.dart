import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/save_trip_details_state.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/trip_details_event.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/trip_details_state.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class SaveTripDetailsBloc extends Bloc<TripDetailsEvent, SaveTripDetailsState> {
  final TripManagerRepository _tripMangerRepository;

  SaveTripDetailsBloc({required TripManagerRepository tripMangerRepository})
      : _tripMangerRepository = tripMangerRepository,
        super(
            SaveTripDetailsState(tripDataResponse: TripDataResponse.inital())) {
    on<SaveTripDetails>(_saveTripDetails);
  }

  Future<void> _saveTripDetails(
    TripDetailsEvent event,
    Emitter<SaveTripDetailsState> emit,
  ) async {
    SaveTripDetails saveTripDetails = event as SaveTripDetails;
    emit(state.copyWith(
        status: SaveTripDetailsStatus.loading,
        tripDataResponse: TripDataResponse.inital()));
    try {
      final TripDataResponse tripDataResponse = await _tripMangerRepository
          .updateTrip(saveTripDetails.tripManagerPayload);
      emit(state.copyWith(
          status: SaveTripDetailsStatus.success,
          tripDataResponse: tripDataResponse));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(
          status: SaveTripDetailsStatus.failure,
          tripDataResponse: TripDataResponse.inital()));
    }
  }
}
