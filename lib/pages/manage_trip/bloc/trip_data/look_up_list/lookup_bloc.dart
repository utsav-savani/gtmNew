import 'package:gtm/pages/manage_trip/bloc/trip_data/look_up_list/lookup_event.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/look_up_list/lookup_state.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class LookupBloc extends Bloc<LookupEvent, LookupListState> {
  final TripManagerRepository _tripMangerRepository;
  List<TripPOCContact> lookupList = [];

  LookupBloc({required TripManagerRepository tripMangerRepository})
      : _tripMangerRepository = tripMangerRepository,
        super(const LookupListState()) {
    on<FetchLookupList>(_getLookupList);
    on<SearchLookupList>(_searchLookUpList);
  }

  Future<void> _getLookupList(
    LookupEvent event,
    Emitter<LookupListState> emit,
  ) async {
    FetchLookupList fetchLookupList = event as FetchLookupList;
    if(fetchLookupList.customerId==0){
      return;
    }
    emit(state.copyWith(status: FetchLookupListState.loading, lookupList: []));
    try {
      final lookupList = await _tripMangerRepository.getTripLookUpData(
          customerId: fetchLookupList.customerId);
      this.lookupList.clear();
      this.lookupList.addAll(lookupList);
      emit(state.copyWith(
        status: FetchLookupListState.success,
        lookupList: lookupList,
      ));
    } catch (e) {
      log(e.toString());
      emit(
          state.copyWith(status: FetchLookupListState.failure, lookupList: []));
    }
  }

  Future<void> _searchLookUpList(
    LookupEvent event,
    Emitter<LookupListState> emit,
  ) async {
    try {
      SearchLookupList searchLookupList = event as SearchLookupList;
      String searchText = searchLookupList.searchText.toLowerCase();
      if (searchText.isEmpty) {
        emit(state.copyWith(
          status: FetchLookupListState.success,
          lookupList: lookupList,
        ));
        return;
      }
      List<TripPOCContact> searchList = lookupList.where((element) {
        return element.name.contains(searchText) ||
            element.priority.toString().contains(searchText);
      }).toList();
      emit(state.copyWith(
        status: FetchLookupListState.success,
        lookupList: searchList,
      ));
    } catch (e) {
      log(e.toString());
      emit(
          state.copyWith(status: FetchLookupListState.failure, lookupList: []));
    }
  }

}
