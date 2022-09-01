import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:country_repository/country_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:gtm/pages/countries/bloc/country_event.dart';

part 'country_general_info_state.dart';

class CountryGeneralInfoBloc
    extends Bloc<CountryEvent, CountryGeneralInfoState> {
  final CountryRepository _countryRepository;

  CountryGeneralInfoBloc({required CountryRepository countryRepository})
      : _countryRepository = countryRepository,
        super(const CountryGeneralInfoState()) {
    on<FetchCountryGeneralInfo>(_getCountryGeneralInfo);
  }

  Future<void> _getCountryGeneralInfo(
      CountryEvent event,
      Emitter<CountryGeneralInfoState> emit,
      ) async {
    emit(state.copyWith(
        status: FetchGeneralInfoStatus.loading, country: const Country()));
    try {
      FetchCountryHealthInfo fetchCountryHealthInfo =
      event as FetchCountryHealthInfo;
      final country = await _countryRepository
          .getGeneralInfo(fetchCountryHealthInfo.countryID);
      if (country == null) {
        emit(state.copyWith(
            status: FetchGeneralInfoStatus.failure, country: const Country()));
        return;
      }
      emit(state.copyWith(
        status: FetchGeneralInfoStatus.success,
        country: country,
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(
          status: FetchGeneralInfoStatus.failure, country: const Country()));
    }
  }
}
