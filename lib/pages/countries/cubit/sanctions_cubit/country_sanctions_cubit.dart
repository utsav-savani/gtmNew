import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:country_repository/country_repository.dart';
import 'package:equatable/equatable.dart';

part 'country_sanctions_state.dart';

class CountrySanctionsCubit extends Cubit<CountrySanctionsState> {
  CountrySanctionsCubit({required this.countryRepository}) : super(const CountrySanctionsState());

  final CountryRepository countryRepository;
  //List<Sanction>? sanctions = [];

  Future<void> getCountrySanctions(int countryId) async {
    emit(state.copyWith(status: FetchSanctionStatus.loading, sanctions: []));
    try {
      final sanctions = await countryRepository.getSanctions(countryId);
      // sanctions!.clear();
      // sanctions.addAll(sanctions);
      emit(state.copyWith(
        status: FetchSanctionStatus.success,
        sanctions: sanctions!,
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: FetchSanctionStatus.failure, sanctions: []));
    }
  }

  Future<void> searchCountrySanctions(String searchString, bool clear) async {
    try {
      final filteredSanctions = await countryRepository.getSanctionSearch(searchString, clear);
      emit(state.copyWith(
        status: FetchSanctionStatus.searchSuccess,
        sanctions: filteredSanctions!,
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: FetchSanctionStatus.searchFailed, sanctions: []));
    }
  }

  // void searchCountrySanctions() {
  //   String searchText = '';
  //   SearchCountrySanctions searchCountries = SearchCountrySanctions;
  //   searchText = searchCountries.searchText.toLowerCase();
  //   if (searchText.isEmpty) {
  //     emit(state.copyWith(
  //       status: FetchSanctionStatus.success,
  //       sanctions: sanctions!,
  //     ));
  //   } else {
  //     List<Sanction> filteredSanctions = sanctions!.where((element) {
  //       return true;
  //     }).toList();
  //     emit(state.copyWith(
  //       status: FetchSanctionStatus.success,
  //       sanctions: filteredSanctions,
  //     ));
  //   }
  // }
}
