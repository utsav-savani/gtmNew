import 'package:gtm/pages/manage_trip/bloc/_schedule/trip_cancelled_sequence_event.dart';
import 'package:gtm/pages/manage_trip/bloc/_schedule/trip_cancelled_sequence_state.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripCancelledSequenceBloc
    extends Bloc<TripCancelledSequenceEvent, TripCancelledSequenceState> {
  static const String all = 'All',
      captain = 'Captain',
      crew = 'Crew',
      passenger = 'Passenger';

  final TripManagerScheduleRepository _tripManagerScheduleRepository;
  List<TripSchedule> tripSchedules = [];

  TripCancelledSequenceBloc(
      {required TripManagerScheduleRepository tripManagerScheduleRepository})
      : _tripManagerScheduleRepository = tripManagerScheduleRepository,
        super(const TripCancelledSequenceState()) {
    on<FetchCancelledSequence>(_getCancelledSequences);
  }

  Future<void> _getCancelledSequences(
    TripCancelledSequenceEvent event,
    Emitter<TripCancelledSequenceState> emit,
  ) async {
    FetchCancelledSequence fetchCancelledSequence =
        event as FetchCancelledSequence;
    if (fetchCancelledSequence.tripId.isNaN) {
      return;
    }

    emit(state.copyWith(
        status: TripCancelledSequenceStatus.loading, tripSchedules: []));
    try {
      final tripSchedules = await _tripManagerScheduleRepository
          .getCancelledTripSchedule(tripId: fetchCancelledSequence.tripId);
      tripSchedules.clear();
      tripSchedules.addAll(tripSchedules);
      emit(state.copyWith(
        status: TripCancelledSequenceStatus.success,
        tripSchedules: tripSchedules,
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(
          status: TripCancelledSequenceStatus.failure, tripSchedules: []));
    }
  }
}
