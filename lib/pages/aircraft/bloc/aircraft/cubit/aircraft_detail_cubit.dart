// ignore_for_file: prefer_const_constructors

import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:bloc/bloc.dart';

part 'aircraft_detail_state.dart';

class AircraftDetailCubit extends Cubit<AircraftDetailState> {
  final AircraftRepository _aircraftRepository;
  AircraftDetailCubit(this._aircraftRepository)
      : super(AircraftDetailInitial(status: AircraftDetailStatus.initial));

  Future<void> loadBasicDetails(int? aircraftId) async {
    try {
      emit(AircraftDetailState(
          status: AircraftDetailStatus.loading,
          aircraftDetails: state.aircraftDetails,
          customers: state.customers,
          operators: state.operators,
          aircraftTypes: state.aircraftTypes,
          countries: state.countries,
          baseAiports: state.baseAiports));
      List<Customer> customers = await UserRepository().getCustomers();
      List<Customers> operators =
          await _aircraftRepository.getOperatorList(page: 0);
      List<AircraftType> aircraftTypes =
          await _aircraftRepository.getAircraftTypeList();
      List<Country> countryList = await _aircraftRepository.getCountryList();
      AircraftDetails? aircraft;
      if (aircraftId != null) {
        aircraft = await _aircraftRepository.getAirCraftDetails(aircraftId);
      }
      emit(AircraftDetailState(
          status: AircraftDetailStatus.sucess,
          aircraftDetails: aircraft,
          customers: customers,
          operators: operators,
          aircraftTypes: aircraftTypes,
          countries: countryList,
          baseAiports: state.baseAiports));
    } catch (e) {
      emit(AircraftDetailState(
          status: AircraftDetailStatus.failure,
          aircraftDetails: state.aircraftDetails,
          customers: state.customers,
          operators: state.operators,
          aircraftTypes: state.aircraftTypes,
          countries: state.countries,
          baseAiports: state.baseAiports));
    }
  }

  Future<void> loadBaseAirport(int countryId, {int page = 0}) async {
    try {
      emit(AircraftDetailState(
          status: AircraftDetailStatus.sucess,
          aircraftDetails: state.aircraftDetails,
          customers: state.customers,
          operators: state.operators,
          aircraftTypes: state.aircraftTypes,
          countries: state.countries,
          baseAiports: state.baseAiports));
      List<CountryAirport> baseAirports =
          await _aircraftRepository.getAirportsForCountry(countryId, page);
      List<CountryAirport> temp = state.baseAiports;
      if (page == 0) {
        temp.clear();
        temp.addAll(baseAirports);
      }
      emit(AircraftDetailState(
          status: AircraftDetailStatus.sucess,
          aircraftDetails: state.aircraftDetails,
          customers: state.customers,
          operators: state.operators,
          aircraftTypes: state.aircraftTypes,
          countries: state.countries,
          baseAiports: temp));
    } catch (e) {
      emit(AircraftDetailState(
          status: AircraftDetailStatus.sucess,
          aircraftDetails: state.aircraftDetails,
          customers: state.customers,
          operators: state.operators,
          aircraftTypes: state.aircraftTypes,
          countries: state.countries,
          baseAiports: state.baseAiports));
    }
  }

  Future<void> createAircraft(CreateAircraft aircraft) async {
    try {
      emit(AircraftDetailState(
          status: AircraftDetailStatus.loading,
          aircraftDetails: state.aircraftDetails,
          customers: state.customers,
          operators: state.operators,
          aircraftTypes: state.aircraftTypes,
          countries: state.countries,
          baseAiports: state.baseAiports));
      bool res = await _aircraftRepository.createAircraft(aircraft);
      if (res) {
        emit(AircraftDetailState(
            status: AircraftDetailStatus.sucess,
            aircraftDetails: state.aircraftDetails,
            customers: state.customers,
            operators: state.operators,
            aircraftTypes: state.aircraftTypes,
            countries: state.countries,
            baseAiports: state.baseAiports));
      } else {
        emit(AircraftDetailState(
            status: AircraftDetailStatus.failure,
            aircraftDetails: state.aircraftDetails,
            customers: state.customers,
            operators: state.operators,
            aircraftTypes: state.aircraftTypes,
            countries: state.countries,
            baseAiports: state.baseAiports));
      }
    } catch (e) {
      emit(AircraftDetailState(
          status: AircraftDetailStatus.failure,
          aircraftDetails: state.aircraftDetails,
          customers: state.customers,
          operators: state.operators,
          aircraftTypes: state.aircraftTypes,
          countries: state.countries,
          baseAiports: state.baseAiports));
    }
  }

  // AircraftId is required in the object
  Future<void> updateAircraft(CreateAircraft aircraft) async {
    try {
      emit(AircraftDetailState(
          status: AircraftDetailStatus.loading,
          aircraftDetails: state.aircraftDetails,
          customers: state.customers,
          operators: state.operators,
          aircraftTypes: state.aircraftTypes,
          countries: state.countries,
          baseAiports: state.baseAiports));
      bool res = await _aircraftRepository.updateAircraft(aircraft);
      if (res) {
        emit(AircraftDetailState(
            status: AircraftDetailStatus.sucess,
            aircraftDetails: state.aircraftDetails,
            customers: state.customers,
            operators: state.operators,
            aircraftTypes: state.aircraftTypes,
            countries: state.countries,
            baseAiports: state.baseAiports));
      } else {
        emit(AircraftDetailState(
            status: AircraftDetailStatus.failure,
            aircraftDetails: state.aircraftDetails,
            customers: state.customers,
            operators: state.operators,
            aircraftTypes: state.aircraftTypes,
            countries: state.countries,
            baseAiports: state.baseAiports));
      }
    } catch (e) {
      emit(AircraftDetailState(
          status: AircraftDetailStatus.failure,
          aircraftDetails: state.aircraftDetails,
          customers: state.customers,
          operators: state.operators,
          aircraftTypes: state.aircraftTypes,
          countries: state.countries,
          baseAiports: state.baseAiports));
    }
  }
}
