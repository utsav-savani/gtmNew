import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:country_repository/country_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:gtm/pages/countries/bloc/country_event.dart';

part 'country_alerts_state.dart';

class CountryAlertsBLoc extends Bloc<CountryEvent, CountryAlertsState> {
  final CountryRepository _countryRepository;
  List<Alert> _alerts = [];

  CountryAlertsBLoc({required CountryRepository countryRepository})
      : _countryRepository = countryRepository,
        super(const CountryAlertsState()) {
    on<FetchCountryAlerts>(_getCountryAlerts);
    on<SearchCountryAlerts>(_searchCountryAlerts);
  }

  Future<void> _getCountryAlerts(
    CountryEvent event,
    Emitter<CountryAlertsState> emit,
  ) async {
    emit(state.copyWith(status: FetchCountryAlertStatus.loading, alerts: []));
    try {
      FetchCountryAlerts fetchCountryAlerts = event as FetchCountryAlerts;
      final countryAlerts =
          await _countryRepository.getAlerts(fetchCountryAlerts.countryID);
      _alerts.clear();
      _alerts.addAll(countryAlerts??[]);
      emit(state.copyWith(
        status: FetchCountryAlertStatus.success,
        alerts: countryAlerts ?? [],
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: FetchCountryAlertStatus.failure, alerts: []));
    }
  }

  void _searchCountryAlerts(
      CountryEvent event,
      Emitter<CountryAlertsState> emit,
      ) {
    String searchText = '';
    SearchCountryAlerts searchCountries = event as SearchCountryAlerts;
    searchText = searchCountries.searchText.toLowerCase();
    if (searchText.isEmpty) {
      emit(state.copyWith(
        status: FetchCountryAlertStatus.success,
        alerts: _alerts,
      ));
    } else {
      List<Alert> filteredCountries = _alerts.where((element) {
        // TODO Implement alerts search
        return true;
      }).toList();
      emit(state.copyWith(
        status: FetchCountryAlertStatus.success,
        alerts: filteredCountries,
      ));
    }
  }

}
