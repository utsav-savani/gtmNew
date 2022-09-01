import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/trip_details_event.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/trip_details_state.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripDetailsBloc extends Bloc<TripDetailsEvent, FetchTripDetailsState> {
  final TripManagerRepository _tripMangerRepository;

  TripDetailsBloc({required TripManagerRepository tripMangerRepository})
      : _tripMangerRepository = tripMangerRepository,
        super(
          FetchTripDetailsState(
            status: FetchTripDetailsStatus.initial,
            tripDetail: TripDetail.initial(),
          ),
        ) {
    on<FetchTripDetails>(_fetchTripDetails);
  }

  Future<void> _fetchTripDetails(
    TripDetailsEvent event,
    Emitter<FetchTripDetailsState> emit,
  ) async {
    FetchTripDetails fetchTripDetails = event as FetchTripDetails;
    if (fetchTripDetails.guid.isEmpty) {
      return;
    }
    emit(state.copyWith(
        status: FetchTripDetailsStatus.loading,
        tripDetail: TripDetail.initial()));
    try {
      final TripDetail tripDetail = await _tripMangerRepository
          .getTripManagerDetails(guid: fetchTripDetails.guid);
      emit(
        state.copyWith(
          status: FetchTripDetailsStatus.success,
          tripDetail: tripDetail,
        ),
      );
    } catch (e) {
      log(e.toString());
      emit(
        state.copyWith(
          status: FetchTripDetailsStatus.failure,
          tripDetail: TripDetail.initial(),
        ),
      );
    }
  }
}
