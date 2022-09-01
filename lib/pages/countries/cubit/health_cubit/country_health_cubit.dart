import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:country_repository/country_repository.dart';
import 'package:equatable/equatable.dart';

part 'country_health_state.dart';

class CountryHealthCubit extends Cubit<CountryHealthState> {
  CountryHealthCubit({required this.countryRepository}) : super(CountryHealthInitial());

  final CountryRepository countryRepository;

  Future<void> getCountryHealthInfo(int countryId) async {
    emit(CountryHealthLoading());
    try {
      final countryHealth = await countryRepository.getHealthInfo(countryId);
      emit(CountryHealthSuccess(countryHealth!));
    } catch (e) {
      log(e.toString());
      emit(CountryHealthFailure(e.toString()));
    }
  }
}
