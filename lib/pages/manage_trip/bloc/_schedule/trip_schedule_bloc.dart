import 'package:flight_category_repository/flight_category_repository.dart';
import 'package:gtm/pages/manage_trip/bloc/_schedule/trip_schedule_event.dart';
import 'package:gtm/pages/manage_trip/bloc/_schedule/trip_schedule_state.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripScheduleListBloc
    extends Bloc<TripScheduleListEvent, TripScheduleListState> {
  final TripManagerScheduleRepository _tripManagerScheduleRepository;
  final FlightCategoryRepository _flightCategoryRepository;
  List<TripSchedulePrePayload> tripScheduleList = [];

  TripScheduleListBloc(
      {required TripManagerScheduleRepository tripManagerScheduleRepository,
      required FlightCategoryRepository flightCategoryRepository})
      : _tripManagerScheduleRepository = tripManagerScheduleRepository,
        _flightCategoryRepository = flightCategoryRepository,
        super(const TripScheduleListState()) {
    on<FetchScheduleList>(_getScheduleList);
    // on<GetFlightCategoryEvent>(_getFlightCategories);
  }

  Future<void> _getScheduleList(
    TripScheduleListEvent event,
    Emitter<TripScheduleListState> emit,
  ) async {
    FetchScheduleList fetchScheduleList = event as FetchScheduleList;
    if (fetchScheduleList.tripId != null) return;

    emit(state.copyWith(
        status: FetchTripScheduleListState.loading, tripScheduleList: []));
    try {
      final schedules = await _tripManagerScheduleRepository
          .getAndGenerateTripSchedulePayload(
        guid: "15333",
      );
      tripScheduleList.clear();
      tripScheduleList.addAll(schedules);
      emit(state.copyWith(
        status: FetchTripScheduleListState.success,
        tripScheduleList: schedules,
      ));
    } catch (e) {
      log(e.toString());
      emit(
        state.copyWith(
          status: FetchTripScheduleListState.failure,
          tripScheduleList: [],
        ),
      );
    }
  }

  Future<void> _getFlightCategories(
      GetFlightCategoryEvent event, Emitter<TripScheduleListState> emit) async {
    try {
      final flightCategories = await _flightCategoryRepository
          .getFlightCategories(customerId: event.customerId);
      emit(FlightCategorySuccess(flightCategories));
    } catch (e) {
      log(e.toString());
    }
  }
}
