import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:people_repository/people_repository.dart';

part 'companies_state.dart';

class CompaniesCubit extends Cubit<CompaniesState> {
  final PeopleRepository peopleRepository;
  CompaniesCubit({required this.peopleRepository})
      : super(const CompaniesInitial(status: CompanyStatus.initial));
  Future<void> updatePersonCompanies(
      {required int customerId,
      required String guid,
      required Object form,
      required bool isPassenger}) async {
    emit(const CompaniesState(status: CompanyStatus.loading));
    try {
      final res = await peopleRepository.updatePersonData(
          form, customerId, guid, isPassenger);
      if (res) {
        emit(const CompaniesState(status: CompanyStatus.success));
      } else {
        emit(const CompaniesState(status: CompanyStatus.failure));
      }
    } catch (e) {
      emit(const CompaniesState(status: CompanyStatus.failure));
    }
  }
}
