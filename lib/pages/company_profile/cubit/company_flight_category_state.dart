part of 'company_flight_category_cubit.dart';

enum CompanyFlightCategoryStatus {
  initial,
  loading,
  success,
  failure,
  reset,
}

class CompanyFlightCategoryState extends Equatable {
  final CompanyFlightCategoryStatus status;
  final List<CompanyProfileFlightCategory>? customerFlightCategoryList;
  final List<FlightCategory> flightcategories;

  const CompanyFlightCategoryState(
      {this.status = CompanyFlightCategoryStatus.initial,
      this.customerFlightCategoryList,
      required this.flightcategories});

  CompanyFlightCategoryState copyWith({
    CompanyFlightCategoryStatus? status,
    List<CompanyProfileFlightCategory>? customerFlightCategoryList,
  }) {
    return CompanyFlightCategoryState(
        status: status ?? this.status,
        customerFlightCategoryList: customerFlightCategoryList,
        flightcategories: const []);
  }

  @override
  List<Object?> get props =>
      [status, customerFlightCategoryList, flightcategories];
}
