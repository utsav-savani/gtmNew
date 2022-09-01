import 'dart:developer';

import 'package:airport_repository/airport_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'paginated_airport_event.dart';
part 'paginated_airport_state.dart';

class PaginatedAirportBloc
    extends Bloc<PaginatedAirportEvent, PaginatedAirportState> {
  final PaginatedAirportRepository _airportRepository;

  PaginatedAirportRepository get airportRepository => _airportRepository;

  PaginatedAirportBloc({
    required PaginatedAirportRepository paginatedAirportRepository,
  })  : _airportRepository = paginatedAirportRepository,
        super(const PaginatedAirportState()) {
    on<FetchPaginatedAirportData>(_getPaginatedAirports);
  }

  Future<void> _getPaginatedAirports(
    PaginatedAirportEvent event,
    Emitter<PaginatedAirportState> emit,
  ) async {
    emit(state.copyWith(
        status: FetchAirportStatus.loading, airports: AirportData(0, [])));
    try {
      final aircraft = await _airportRepository.getPaginatedAirports();
      emit(state.copyWith(
        status: FetchAirportStatus.success,
        airports: aircraft,
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(
          status: FetchAirportStatus.failure, airports: AirportData(0, [])));
    }
  }
}
