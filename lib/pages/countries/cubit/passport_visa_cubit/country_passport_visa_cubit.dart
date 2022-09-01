import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:country_repository/country_repository.dart';
import 'package:equatable/equatable.dart';

part 'country_passport_visa_state.dart';

class CountryPassportVisaCubit extends Cubit<CountryPassportVisaState> {
  CountryPassportVisaCubit({required this.countryRepository}) : super(const CountryPassportVisaState());

  CountryRepository countryRepository;

  Future<void> getCountryPassportVisaInfo(int countryId) async {
    emit(state.copyWith(status: FetchPassportVisaStatus.loading, passportVisa: []));
    try {
      final List<PassportVisa>? _passportVisaList = await countryRepository.getPassportVisaInfo(countryId);
      emit(state.copyWith(status: FetchPassportVisaStatus.success, passportVisa: _passportVisaList!));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: FetchPassportVisaStatus.failure, passportVisa: []));
    }
  }
}
