part of 'company_profile_cubit.dart';

enum CompanyProfileStatus {
  initial,
  loading,
  success,
  failure,
  reset,
}

class CompanyProfileState extends Equatable {
  final CompanyProfileStatus status;
  final List<CompanyProfile>? companyProfiles;
  final List<CompanyProfileFlightCategory>? flightCategoryList;

  const CompanyProfileState({
    this.status = CompanyProfileStatus.initial,
    this.companyProfiles,
    this.flightCategoryList,
  });

  CompanyProfileState copyWith({
    CompanyProfileStatus? status,
    required List<CompanyProfile>? companyProfiles,
    List<CompanyProfileFlightCategory>? flightCategoryList,
  }) {
    return CompanyProfileState(
      status: status ?? this.status,
      companyProfiles: companyProfiles,
      flightCategoryList: flightCategoryList,
    );
  }

  @override
  List<Object?> get props => [status, companyProfiles, flightCategoryList];
}
