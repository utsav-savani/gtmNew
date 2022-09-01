import 'package:gtm/pages/manage_trip/bloc/services/trip_service/airport_requirement_state.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/flight_requirement_state.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_event.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_state.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class AirportRequirementBloc extends Bloc<TripServiceEvent, AirportRequirementState> {
  final TripManagerServiceRepository _tripManagerServiceRepository;

  AirportRequirementBloc({required TripManagerServiceRepository tripManagerServiceRepository})
      : _tripManagerServiceRepository = tripManagerServiceRepository,
        super(const AirportRequirementState()) {
    on<FetchAirportRequirement>(_fetchAirportRequirement);
  }

  Future<void> _fetchAirportRequirement(
    TripServiceEvent event,
    Emitter<AirportRequirementState> emit,
  ) async {
    FetchAirportRequirement fetchAirportRequirement = event as FetchAirportRequirement;
    if (fetchAirportRequirement.airportID == 0) {
      emit(state.copyWith(status: FetchAirportRequirementStatus.failure, airportDetailRequirement: const AirportDetailRequirement(airportId: 0)));
      return;
    }
    emit(state.copyWith(status: FetchAirportRequirementStatus.loading, airportDetailRequirement: const AirportDetailRequirement(airportId: 0)));
    try {
      var countryAirportRequirement = await _tripManagerServiceRepository.getAirportRequirement(airportId: fetchAirportRequirement.airportID);

      emit(state.copyWith(
        status: FetchAirportRequirementStatus.success,
        airportDetailRequirement: countryAirportRequirement ?? const AirportDetailRequirement(airportId: 0),
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: FetchAirportRequirementStatus.failure, airportDetailRequirement: const AirportDetailRequirement(airportId: 0)));
    }
  }
}
