part of 'companies_cubit.dart';

enum CompanyStatus { initial, loading, success, failure }

class CompaniesState extends Equatable {
  final CompanyStatus status;
  const CompaniesState({required this.status});

  @override
  List<Object> get props => [status];
}

class CompaniesInitial extends CompaniesState {
  const CompaniesInitial({required CompanyStatus status})
      : super(status: status);
}
