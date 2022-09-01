// ignore_for_file: prefer_const_constructors_in_immutables

part of 'aircraft_detail_cubit.dart';

enum AircraftDetailStatus { initial, loading, sucess, failure }

class AircraftDetailState {
  final AircraftDetailStatus status;
  final AircraftDetails? aircraftDetails;
  final List<Country> countries;
  final List<Customer> customers;
  final List<Customers> operators;
  final List<AircraftType> aircraftTypes;
  final List<CountryAirport> baseAiports;
  const AircraftDetailState(
      {required this.aircraftDetails,
      required this.status,
      required this.customers,
      required this.operators,
      required this.aircraftTypes,
      required this.countries,
      required this.baseAiports});

  @override
  List<Object> get props =>
      [status, customers, operators, aircraftTypes, countries, baseAiports];
}

class AircraftDetailInitial extends AircraftDetailState {
  AircraftDetailInitial({required AircraftDetailStatus status})
      : super(
            status: status,
            aircraftDetails: null,
            customers: [],
            operators: [],
            aircraftTypes: [],
            countries: [],
            baseAiports: []);
}
