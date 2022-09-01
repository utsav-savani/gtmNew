import 'package:trip_manager_repository/trip_manager_repository.dart';

enum FetchFlightRequirementStatus { initial, loading, success, failure }

class FlightRequirementState extends Equatable {
  final FetchFlightRequirementStatus status;
  final List<CountryAirportRequirement> countryAirportRequirement;

  const FlightRequirementState({
    this.status = FetchFlightRequirementStatus.initial,
    this.countryAirportRequirement = const [],
  });

  FlightRequirementState copyWith({
    FetchFlightRequirementStatus? status,
    required List<CountryAirportRequirement> countryAirportRequirement,
  }) {
    return FlightRequirementState(
      status: status ?? this.status,
      countryAirportRequirement: countryAirportRequirement,
    );
  }

  @override
  List<Object?> get props => [status, countryAirportRequirement];
}
