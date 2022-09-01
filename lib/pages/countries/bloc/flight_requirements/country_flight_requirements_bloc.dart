import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:country_repository/country_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:gtm/pages/countries/bloc/country_event.dart';

part 'country_flight_requirements_state.dart';

class CountryFlightRequirementsBloc
    extends Bloc<CountryEvent, CountryFlightRequirementState> {
  final CountryRepository _countryRepository;
  final List<FlightRequirement> _flightRequirements = [];

  CountryFlightRequirementsBloc({required CountryRepository countryRepository})
      : _countryRepository = countryRepository,
        super(const CountryFlightRequirementState()) {
    on<FetchFlightRequirements>(_getFlightRequirements);
    on<SearchFlightRequirements>(_searchFlightRequirements);
  }

  Future<void> _getFlightRequirements(
    CountryEvent event,
    Emitter<CountryFlightRequirementState> emit,
  ) async {
    emit(state.copyWith(
        status: FetchFlightRequirementsStatus.loading, flightRequirements: []));
    try {
      FetchFlightRequirements fetchFlightRequirements =
          event as FetchFlightRequirements;
      final flightRequirements = await _countryRepository
          .getFlightRequirements(fetchFlightRequirements.countryID);
      _flightRequirements.clear();
      _flightRequirements.addAll(_flightRequirements);
      emit(state.copyWith(
        status: FetchFlightRequirementsStatus.success,
        flightRequirements: flightRequirements ?? [],
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(
          status: FetchFlightRequirementsStatus.failure,
          flightRequirements: []));
    }
  }

  void _searchFlightRequirements(
    CountryEvent event,
    Emitter<CountryFlightRequirementState> emit,
  ) {
    String searchText = '';
    SearchFlightRequirements searchFlightRequirements =
        event as SearchFlightRequirements;
    searchText = searchFlightRequirements.searchText.toLowerCase();
    if (searchText.isEmpty) {
      emit(state.copyWith(
        status: FetchFlightRequirementsStatus.success,
        flightRequirements: _flightRequirements,
      ));
    } else {
      List<FlightRequirement> filteredCountries =
          _flightRequirements.where((element) {
        List<String> flightCategories = element.flightCategories ?? [];
        List<String> services = element.services ?? [];
        String through = element.through ?? '';
        String leadTime = element.leadTime ?? '';
        String permitValidity = element.permValidity ?? '';

        return through.toLowerCase().contains(searchText) ||
            leadTime.toLowerCase().contains(searchText) ||
            permitValidity.toLowerCase().contains(searchText);
      }).toList();
      emit(state.copyWith(
        status: FetchFlightRequirementsStatus.success,
        flightRequirements: filteredCountries,
      ));
    }
  }
}
