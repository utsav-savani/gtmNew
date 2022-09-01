import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flight_category_repository/flight_category_repository.dart';

part 'flight_category_event.dart';
part 'flight_category_state.dart';

class FlightCategoryBloc
    extends Bloc<FlightCategoryEvent, FlightCategoryState> {
  final FlightCategoryRepository _flightCategoryRepository;

  FlightCategoryBloc(
      {required FlightCategoryRepository flightCategoryRepository})
      : _flightCategoryRepository = flightCategoryRepository,
        super(const FlightCategoryState()) {
    on<FetchFlightCategoryData>(_getFlightCategories);
  }

  Future<void> _getFlightCategories(
    FlightCategoryEvent event,
    Emitter<FlightCategoryState> emit,
  ) async {
    FetchFlightCategoryData flightCategoryData = event as FetchFlightCategoryData;
    if(flightCategoryData.customerID==0){
      return;
    }
    emit(state
        .copyWith(status: FetchCategoriesStatus.loading, flightcategories: []));

    try {
      final flightCategories =
          await _flightCategoryRepository.getFlightCategories(customerId: flightCategoryData.customerID.toString());

      emit(state.copyWith(
        status: FetchCategoriesStatus.success,
        flightcategories: flightCategories,
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(
          status: FetchCategoriesStatus.failure, flightcategories: []));
    }
  }
}
