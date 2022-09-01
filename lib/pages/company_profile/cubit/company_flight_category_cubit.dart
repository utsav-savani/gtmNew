import 'dart:developer';

import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'company_flight_category_state.dart';

class CompanyFlightCategoryCubit extends Cubit<CompanyFlightCategoryState> {
  CompanyFlightCategoryCubit({required this.companyProfileRepository})
      : super(const CompanyFlightCategoryState(flightcategories: []));

  CompanyProfileRepository companyProfileRepository;

  Future<void> getCompanyProfileFlightCategory(int customerId) async {
    emit(CompanyFlightCategoryState(
      customerFlightCategoryList: state.customerFlightCategoryList,
      status: CompanyFlightCategoryStatus.loading,
      flightcategories: state.flightcategories,
    ));

    try {
      final flightCategoryList = await companyProfileRepository
          .getCompanyProfileFlightCategory(customerId);
      final allCategories =
          await companyProfileRepository.getAllFlightCategories();
      emit(CompanyFlightCategoryState(
        customerFlightCategoryList: flightCategoryList,
        status: CompanyFlightCategoryStatus.success,
        flightcategories: allCategories,
      ));
    } catch (e) {
      log("Error FC: " + e.toString());
      emit(CompanyFlightCategoryState(
        customerFlightCategoryList: state.customerFlightCategoryList,
        status: CompanyFlightCategoryStatus.failure,
        flightcategories: state.flightcategories,
      ));
    }
  }

  Future<void> updateFlightcategory(
      {required int customerId, required List<int> categoryIds}) async {
    emit(CompanyFlightCategoryState(
      customerFlightCategoryList: state.customerFlightCategoryList,
      status: CompanyFlightCategoryStatus.loading,
      flightcategories: state.flightcategories,
    ));

    try {
      final res = await companyProfileRepository
          .udpateCompanyProfileFlightCategory(customerId, categoryIds);
      if (res) {
        emit(CompanyFlightCategoryState(
          customerFlightCategoryList: state.customerFlightCategoryList,
          status: CompanyFlightCategoryStatus.success,
          flightcategories: state.flightcategories,
        ));
      } else {
        emit(CompanyFlightCategoryState(
          customerFlightCategoryList: state.customerFlightCategoryList,
          status: CompanyFlightCategoryStatus.failure,
          flightcategories: state.flightcategories,
        ));
      }
    } catch (e) {
      log("Error FC: " + e.toString());
      emit(CompanyFlightCategoryState(
        customerFlightCategoryList: state.customerFlightCategoryList,
        status: CompanyFlightCategoryStatus.failure,
        flightcategories: state.flightcategories,
      ));
    }
  }
}
