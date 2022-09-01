import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_event.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_persons/pob_persons_state.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class POBPersonsBloc extends Bloc<POBEvent, POBPersonsState> {
  static const String
      all = 'All',
      captain = 'Captain',
      crew = 'Crew',
      passenger = 'Passenger';

  final TripManagerPOBRepository _tripManagerPOBRepository;
  List<TripPerson> tripPersons = [];

  POBPersonsBloc({required TripManagerPOBRepository tripManagerPOBRepository})
      : _tripManagerPOBRepository = tripManagerPOBRepository,
        super(const POBPersonsState()) {
    on<FetchPOBPersons>(_getPOBPersons);
  }

  Future<void> _getPOBPersons(
    POBEvent event,
    Emitter<POBPersonsState> emit,
  ) async {
    FetchPOBPersons fetchPOBPersons = event as FetchPOBPersons;
    if (fetchPOBPersons.guid.isEmpty) {
      return;
    }

    emit(state
        .copyWith(status: FetchPOBPersonsState.loading, tripPersons: []));
    try {
      final personsList = await _tripManagerPOBRepository.getAllPersons(
          guid: fetchPOBPersons.guid);
      tripPersons.clear();
      tripPersons.addAll(personsList);
      emit(state.copyWith(
        status: FetchPOBPersonsState.success,
        tripPersons: personsList,
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(
          status: FetchPOBPersonsState.failure, tripPersons: []));
    }
  }
}
