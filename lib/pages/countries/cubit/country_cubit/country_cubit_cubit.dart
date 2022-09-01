import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:country_repository/country_repository.dart';
import 'package:equatable/equatable.dart';

part 'country_cubit_state.dart';

class CountryCubit extends Cubit<CountryCubitState> {
  CountryCubit({required this.countryRepository}) : super(const CountryCubitState());
  final CountryRepository countryRepository;
  final List<Country> _countries = [];

  Future<void> getCountries() async {
    emit(state.copyWith(status: FetchCountryStatus.loading, countries: []));
    try {
      final countries = await countryRepository.getCountries();
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
}
