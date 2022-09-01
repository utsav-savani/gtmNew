import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:country_repository/country_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:gtm/pages/countries/bloc/country_event.dart';

part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryListState> {
  final CountryRepository _countryRepository;
  final List<Country> _countries = [];

  CountryBloc({required CountryRepository countryRepository})
      : _countryRepository = countryRepository,
        super(const CountryListState()) {
    on<FetchCountryList>(_getCountries);
    on<SearchCountries>(_searchCountries);
  }

  Future<void> _getCountries(
    CountryEvent event,
    Emitter<CountryListState> emit,
  ) async {
    emit(state.copyWith(status: FetchCountryStatus.loading, countries: []));

    try {
      final countries = await _countryRepository.getCountries();
      _countries.clear();
      _countries.addAll(countries);
      emit(state.copyWith(
        status: FetchCountryStatus.success,
        countries: countries,
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: FetchCountryStatus.failure, countries: []));
    }
  }

  void _searchCountries(
    CountryEvent event,
    Emitter<CountryListState> emit,
  ) {
    String searchText = '';
    SearchCountries searchCountries = event as SearchCountries;
    searchText = searchCountries.searchText.toLowerCase();
    if (searchText.isEmpty) {
      emit(state.copyWith(
        status: FetchCountryStatus.success,
        countries: _countries,
      ));
    } else {
      List<Country> filteredCountries = _countries.where((element) {
        String name = element.name ?? '';
        String code = element.code ?? '';
        String code3 = element.code3 ?? '';
        return name.toLowerCase().contains(searchText) ||
            code.toLowerCase().contains(searchText) ||
            code3.toLowerCase().contains(searchText);
      }).toList();
      emit(state.copyWith(
        status: FetchCountryStatus.success,
        countries: filteredCountries,
      ));
    }
  }
}
