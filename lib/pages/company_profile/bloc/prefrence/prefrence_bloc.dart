import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:equatable/equatable.dart';

part 'prefrence_event.dart';
part 'prefrence_state.dart';

class PrefrenceBloc extends Bloc<PrefrenceEvent, PrefrenceState> {
  final CompanyProfileRepository _companyProfileRepository;
  PrefrenceBloc({required CompanyProfileRepository companyProfileRepository})
      : _companyProfileRepository = companyProfileRepository,
        super(PrefrenceInitial(status: PrefrenceListStatus.initial)) {
    on<FetchPrefrenceEvent>(_fetchPrefrenceList);
  }

  FutureOr<void> _fetchPrefrenceList(
      FetchPrefrenceEvent event, Emitter<PrefrenceState> emit) async {
    emit(const PrefrenceState(
        status: PrefrenceListStatus.initial, prefrences: []));
    try {
      emit(const PrefrenceState(
          status: PrefrenceListStatus.loading, prefrences: []));
      List<Prefrence> prefrences = await _companyProfileRepository
          .getCustomerPrefrence(event.customerId, event.page);
      emit(PrefrenceState(
          status: PrefrenceListStatus.success, prefrences: prefrences));
    } catch (e) {
      emit(const PrefrenceState(
          status: PrefrenceListStatus.failure, prefrences: []));
    }
  }
}
