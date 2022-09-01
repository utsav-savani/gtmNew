import 'package:gtm/pages/manage_trip/bloc/services/trip_service/flight_requirement_state.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_event.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_state.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class FlightRequirementBloc extends Bloc<TripServiceEvent, FlightRequirementState> {
  final TripManagerServiceRepository _tripManagerServiceRepository;

  FlightRequirementBloc({required TripManagerServiceRepository tripManagerServiceRepository})
      : _tripManagerServiceRepository = tripManagerServiceRepository,
        super(const FlightRequirementState()) {
    on<FetchFlightRequirement>(_fetchFlightRequirement);
  }

  Future<void> _fetchFlightRequirement(
    TripServiceEvent event,
    Emitter<FlightRequirementState> emit,
  ) async {
    FetchFlightRequirement fetchFlightCountryRequirement = event as FetchFlightRequirement;
    if (fetchFlightCountryRequirement.type == TripServiceModalType.LOCATION && fetchFlightCountryRequirement.airportID == 0) {
      emit(state.copyWith(status: FetchFlightRequirementStatus.failure, countryAirportRequirement: []));
      return;
    }

    if (fetchFlightCountryRequirement.type == TripServiceModalType.OVERFLY && fetchFlightCountryRequirement.countryID == 0) {
      emit(state.copyWith(status: FetchFlightRequirementStatus.failure, countryAirportRequirement: []));
      return;
    }

    emit(state.copyWith(status: FetchFlightRequirementStatus.loading, countryAirportRequirement: []));
    try {
      final List<CountryAirportRequirement>? countryAirportRequirement;
      if (fetchFlightCountryRequirement.type == TripServiceModalType.LOCATION) {
        countryAirportRequirement =
            await _tripManagerServiceRepository.getFlightAirportRequirement(airportId: fetchFlightCountryRequirement.airportID);
      } else {
        countryAirportRequirement =
            await _tripManagerServiceRepository.getFlightCountryRequirement(countryId: fetchFlightCountryRequirement.countryID);
      }
      emit(state.copyWith(
        status: FetchFlightRequirementStatus.success,
        countryAirportRequirement: countryAirportRequirement ?? [],
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: FetchFlightRequirementStatus.failure, countryAirportRequirement: []));
    }
  }
}
