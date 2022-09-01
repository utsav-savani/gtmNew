import 'package:trip_manager_repository/trip_manager_repository.dart';

enum FetchAirportRequirementStatus { initial, loading, success, failure }

class AirportRequirementState extends Equatable {
  final FetchAirportRequirementStatus status;
  final AirportDetailRequirement airportDetailRequirement;

  const AirportRequirementState({
    this.status = FetchAirportRequirementStatus.initial,
    this.airportDetailRequirement = const AirportDetailRequirement(airportId: 0),
  });

  AirportRequirementState copyWith({
    FetchAirportRequirementStatus? status,
    required AirportDetailRequirement airportDetailRequirement,
  }) {
    return AirportRequirementState(
      status: status ?? this.status,
      airportDetailRequirement: airportDetailRequirement,
    );
  }

  @override
  List<Object?> get props => [status, airportDetailRequirement];
}
