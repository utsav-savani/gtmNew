import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:country_repository/country_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:gtm/pages/countries/bloc/country_event.dart';

part 'country_sanctions_state.dart';

class CountrySanctionBloc extends Bloc<CountryEvent, CountrySanctionState> {
  final CountryRepository _countryRepository;
  List<Sanction> _sanctions = [];

  CountrySanctionBloc({required CountryRepository countryRepository})
      : _countryRepository = countryRepository,
        super(const CountrySanctionState()) {
    on<FetchCountrySanctions>(_getCountrySanctions);
    on<SearchCountrySanctions>(_searchCountrySanctions);
  }

  Future<void> _getCountrySanctions(
    CountryEvent event,
    Emitter<CountrySanctionState> emit,
  ) async {
    emit(state.copyWith(status: FetchSanctionStatus.loading, sanctions: []));
    try {
      FetchCountrySanctions fetchCountrySanctions =
          event as FetchCountrySanctions;
      final sanctions = await _countryRepository
          .getSanctions(fetchCountrySanctions.countryID);
      _sanctions.clear();
      _sanctions.addAll(sanctions ?? []);
      emit(state.copyWith(
        status: FetchSanctionStatus.success,
        sanctions: sanctions ?? [],
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: FetchSanctionStatus.failure, sanctions: []));
    }
  }

  void _searchCountrySanctions(
    CountryEvent event,
    Emitter<CountrySanctionState> emit,
  ) {
    String searchText = '';
    SearchCountrySanctions searchCountries = event as SearchCountrySanctions;
    searchText = searchCountries.searchText.toLowerCase();
    if (searchText.isEmpty) {
      emit(state.copyWith(
        status: FetchSanctionStatus.success,
        sanctions: _sanctions,
      ));
    } else {
      List<Sanction> filteredSanctions = _sanctions.where((element) {
        // TODO Implement sanctions search
        return true;
      }).toList();
      emit(state.copyWith(
        status: FetchSanctionStatus.success,
        sanctions: filteredSanctions,
      ));
    }
  }
}
