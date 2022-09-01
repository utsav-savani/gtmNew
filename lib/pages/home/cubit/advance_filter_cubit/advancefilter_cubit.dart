import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'advancefilter_state.dart';

class AdvanceFilterCubit extends Cubit<AdvanceFilterState> {
  AdvanceFilterCubit(this.tripManagerRepository, this.filter)
      : super(AdvancefilterInitial());

  TripManagerRepository tripManagerRepository;
  List<TripManagerFilter> filter;
  // void searchByDateChanged(String value) {
  //   final FilterType filterType = FilterType.dirty(value);

  //   emit(state.copyWith(filter: state.filter,  status: Formz.validate([state.filter]),));
  // }

  Future<void> filterReplaceDataTableSource(List<Trip> tripList) async {
    emit(AdvancFilterLoading());
    try {
      final tableData =
          await tripManagerRepository.populateDataTableTrip(tripList);
      emit(AdvancFilterDataTableSuccess(tableData));
    } catch (e) {
      log(e.toString());
      emit(AdvancFilterFailure(e.toString()));
    }
  }
}
