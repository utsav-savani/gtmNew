part of 'person_bloc.dart';

enum FetchPersonDetailStatus { initial, loading, success, failure }

class PersonState {
  FetchPersonDetailStatus detailStatus;
  PersonState({
    required this.detailStatus,
    this.personDetails,
    required this.isPassenger,
    required this.guid,
    this.birthCities,
    this.countries,
    this.addressCities,
    this.pageNo,
    required this.customers,
  });

  Person? personDetails;
  bool isPassenger;
  String? guid;
  Map<int, City>? birthCities;
  Map<int, Country>? countries;
  Map<int, City>? addressCities;
  List<Customer> customers;
  int? pageNo;
  @override
  List<Object?> get props => [detailStatus, customers];
}

copyWith(PersonState state) {
  PersonState newState = PersonState(
      detailStatus: state.detailStatus,
      personDetails: state.personDetails,
      isPassenger: state.isPassenger,
      guid: state.guid,
      birthCities: state.birthCities,
      countries: state.countries,
      addressCities: state.addressCities,
      customers: state.customers,
      pageNo: state.pageNo);
  return newState;
}

class PeopleInitial extends PersonState {
  PeopleInitial({required FetchPersonDetailStatus detailStatus})
      : super(
            detailStatus: detailStatus,
            customers: [],
            isPassenger: false,
            guid: null);
}
