part of 'country_flight_requirements_bloc.dart';

enum FetchFlightRequirementsStatus { initial, loading, success, failure }

class CountryFlightRequirementState extends Equatable {
  final FetchFlightRequirementsStatus status;
  final List<FlightRequirement>? flightRequirements;

  const CountryFlightRequirementState({
    this.status = FetchFlightRequirementsStatus.initial,
    this.flightRequirements,
  });

  CountryFlightRequirementState copyWith({
    FetchFlightRequirementsStatus? status,
    required List<FlightRequirement> flightRequirements,
  }) {
    return CountryFlightRequirementState(
      status: status ?? this.status,
      flightRequirements: flightRequirements,
    );
  }

  @override
  List<Object?> get props => [status, flightRequirements];
}