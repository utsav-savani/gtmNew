import 'dart:developer';

import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'company_profile_state.dart';

class CompanyProfileCubit extends Cubit<CompanyProfileState> {
  CompanyProfileCubit({required this.companyProfileRepository})
      : super(const CompanyProfileState());

  CompanyProfileRepository companyProfileRepository;

  Future<void> fetchCompanyProfileInitial() async {
    emit(state
        .copyWith(companyProfiles: [], status: CompanyProfileStatus.loading));
    try {
      /// need to get the customer ids to get all the list, but now not!!!
      final companyProfileList =
          await companyProfileRepository.getCompanyProfileList();
      emit(state.copyWith(
          companyProfiles: companyProfileList,
          status: CompanyProfileStatus.success));
    } catch (e) {
      log(e.toString());
      emit(state
          .copyWith(companyProfiles: [], status: CompanyProfileStatus.failure));
    }
  }

  Future<void> updateCompanyProfile(CompanyProfile companyProfile,
      {required bool update, required bool reset}) async {
    if (update) {
      emit(state
          .copyWith(companyProfiles: [], status: CompanyProfileStatus.loading));

      try {
        // TODO: need to get the customer ids to get all the list, but now not!!!
        await companyProfileRepository.udpateCompanyProfile(companyProfile);
        emit(state.copyWith(
          companyProfiles: [],
          status: CompanyProfileStatus.success,
        ));
      } catch (e) {
        log(e.toString());
        emit(state.copyWith(
            companyProfiles: [], status: CompanyProfileStatus.failure));
      }
    } else if (reset) {
      emit(state
          .copyWith(companyProfiles: [], status: CompanyProfileStatus.reset));
    }
  }
}
