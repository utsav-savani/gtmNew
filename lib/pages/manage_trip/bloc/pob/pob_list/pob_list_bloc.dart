import 'package:gtm/pages/manage_trip/bloc/pob/pob_event.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_list/pob_list_state.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class POBListBloc extends Bloc<POBEvent, POBListState> {
  static const String all = 'All',
      captain = 'Captain',
      crew = 'Crew',
      passenger = 'Passenger';

  final TripManagerPOBRepository _tripManagerPOBRepository;
  List<TripPobSchedule> tripPOBScheduleList = [];

  POBListBloc({required TripManagerPOBRepository tripManagerPOBRepository})
      : _tripManagerPOBRepository = tripManagerPOBRepository,
        super(const POBListState()) {
    on<FetchPOBList>(_getPOBList);
  }

  Future<void> _getPOBList(
    POBEvent event,
    Emitter<POBListState> emit,
  ) async {
    FetchPOBList fetchPOBLIst = event as FetchPOBList;
    if (fetchPOBLIst.guid.isEmpty) {
      return;
    }

    emit(state
        .copyWith(status: FetchPOBListState.loading, tripPOBListSchedule: null));
    try {
      final TripPobScheduleMain? pobList = await _tripManagerPOBRepository.getTripPOBLists(
          guid: fetchPOBLIst.guid);
      tripPOBScheduleList.clear();
      tripPOBScheduleList.addAll(pobList!.persons);
      emit(state.copyWith(
        status: FetchPOBListState.success,
        tripPOBListSchedule: pobList,
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(
          status: FetchPOBListState.failure, tripPOBListSchedule: null));
    }
  }
}
