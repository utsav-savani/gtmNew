// ignore_for_file: public_member_api_docs

import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:flight_category_repository/flight_category_repository.dart';
import 'package:flutter/material.dart';
import 'package:operator_repository/operator_repository.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TripManagerRepository _tripManagerRepository;
  final UserRepository userRepository;
  final AircraftRepository _aircraftRepository;
  final FlightCategoryRepository _flightCategoryRepository;
  final OperatorRepository _operatorRepository;

  HomeBloc({
    required TripManagerRepository tripManagerRepository,
    required UserRepository userRepository,
    required AircraftRepository aircraftRepository,
    required FlightCategoryRepository flightCategoryRepository,
    required OperatorRepository operatorRepository,
  })  : _tripManagerRepository = tripManagerRepository,
        userRepository = userRepository,
        _aircraftRepository = aircraftRepository,
        _flightCategoryRepository = flightCategoryRepository,
        _operatorRepository = operatorRepository,
        super(HomeInitial()) {
    on<FetchTripData>(_getchTripManagerDashboardData);
    on<SaveUserDetails>(saveUserDetails);
    on<LoadTripDataTable>(fetchTripDataTable);
    on<InitiateTripDraftEvent>(loadCreateDraft);
    on<GetOperatorEvent>(getOperator);
    on<GetFlightCategoryEvent>(getFlightCategory);
    on<CreateTripEvent>(createTrip);
    on<SortByColumnName>(sortByColumn);
    on<FilterAdavnceEvent>(searchForTrips);
  }

  Future<void> sortByColumn(
    SortByColumnName event,
    Emitter<HomeState> emit,
  ) async {
    emit(DataTableLoading());
    try {
      //final tableData = await _tripManagerRepository.;
      // emit(DataTableSuccess(tableData));
    } catch (e) {
      log(e.toString());
      emit(DataTableFailure());
    }
  }

  Future<void> fetchTripDataTable(
    LoadTripDataTable event,
    Emitter<HomeState> emit,
  ) async {
    emit(DataTableLoading());
    try {
      // final tableData = await _tripManagerRepository.populateDataTableTrip(event.tripList, event.context);
      // emit(DataTableSuccess(tableData));
    } catch (e) {
      log(e.toString());
      emit(DataTableFailure());
    }
  }

  Future<void> saveUserDetails(HomeEvent event, Emitter<HomeState> emit) async {
    try {
      final userDetails = userRepository.storeUserDetails();
      debugPrint(userDetails.toString());
    } catch (e) {
      log(e.toString());
      // emit(DashboardFailure());
    }
  }

  Future<void> _getchTripManagerDashboardData(
    HomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(DashboardLoading());

      await Future.delayed(const Duration(seconds: 2));
      final trips = await _tripManagerRepository.getTrips();
      final tripStatistic = await _tripManagerRepository.getTripStats();
      final dataTable =
          await _tripManagerRepository.populateDataTableTrip(trips);

      emit(DashboardSuccess(dataTable, tripStatistic, trips, true, null));
    } catch (e) {
      log(e.toString());
      emit(DashboardFailure());
    }
  }

  Future<void> loadCreateDraft(HomeEvent event, Emitter<HomeState> emit) async {
    emit(const InitialDraftTripLoading());
    try {
      final offices = await userRepository.getOffices();

      /// manually over ridden values changes in future
      _aircraftRepository.setLimit('10');
      _aircraftRepository.setPage('1');
      final airCrafts = await _aircraftRepository.getAircrafts();
      final customers = await userRepository.getCustomers();
      // final flightCategories = await _flightCategoryRepository.getFlightCategories();
      // final operatorCategories = await _operatorRepository.getOperators
      emit(InitialDraftTripSuccess(
        offices,
        airCrafts,
        customers,
      ));
    } catch (e) {
      log(e.toString());
      emit(InitialDraftTripFailure(e.toString()));
    }
  }

  Future<void> getOperator(
      GetOperatorEvent event, Emitter<HomeState> emit) async {
    emit(const OperatorLoading());
    try {
      final operatorCategories =
          await _operatorRepository.getOperators(aircraftId: event.aircraftId);
      emit(OperatorSuccess(operatorCategories));
    } catch (e) {
      log(e.toString());
      emit(OperatorFailure(e.toString()));
    }
  }

  Future<void> getFlightCategory(
      GetFlightCategoryEvent event, Emitter<HomeState> emit) async {
    emit(const FlightCategoryLoading());
    try {
      final flightCategories = await _flightCategoryRepository
          .getFlightCategories(customerId: event.customerId);
      emit(FlightCategorySuccess(flightCategories));
    } catch (e) {
      log(e.toString());
      emit(FlightCategoryFailure(e.toString()));
    }
  }

  Future<void> createTrip(
      CreateTripEvent event, Emitter<HomeState> emit) async {
    emit(const CreateTripStateLoading());
    try {
      final creatorId = await userRepository.readUser();
      TripManagerPayload _payLoad = TripManagerPayload(
        officeId: event.selectedOffice.officeId,
        aircraftId: event.selectedAircraft.aircraftId,
        flightCategoryId: event.selectedFlightCategory.flightCategoryId,
        customerId: event.selectedCustomerId,
        operatorId: event.selectedOperator.customerId,
        tripCostEstimate: event.tripCostEstimate,
        customerReference: event.customerReference,
        subAircrafts: [],
        creatorId: creatorId.data.userId,
      );
      final tripDraftData = await _tripManagerRepository.createTrip(_payLoad);
      emit(CreateTripStateSuccess(tripDraftData));
    } catch (e) {
      log(e.toString());
      emit(CreateTripStateFailure(e.toString()));
    }
  }

  Future<void> searchForTrips(
      FilterAdavnceEvent event, Emitter<HomeState> emit) async {
    emit(DashboardLoading());
    try {
      TripManagerFilter filter = event.filter;
      TripManagerRepository _tripRepo = TripManagerRepository();
      if (filter.searchString() != null) {
        _tripRepo.setSearch(filter.searchString());
      }
      if (filter.fromDate() != null) {
        _tripRepo.setFromDate(filter.fromDate());
      }
      if (filter.toDate() != null) {
        _tripRepo.setToDate(filter.toDate());
      }
      if (filter.searchBy() != null) {
        _tripRepo.setSearchBy(filter.searchBy());
      }
      if (filter.status() != null) {
        _tripRepo.setStatus(filter.status());
      }
      var trips = await _tripRepo.getTrips();
      final dataTable =
          await _tripManagerRepository.populateDataTableTrip(trips);

      if (event.updateStats != null && event.updateStats!) {
        var analytics = await _tripRepo.getTripStats();
        emit(DashboardSuccess(dataTable, analytics, trips, event.updateStats!,
            event.selectedCard));
      } else {
        emit(DashboardSuccess(dataTable, event.statistic!, trips,
            event.updateStats!, event.selectedCard));
      }
    } catch (e) {
      emit(DashboardFailure());
    }
  }
}
