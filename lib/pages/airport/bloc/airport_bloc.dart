import 'dart:developer';

import 'package:airport_repository/airport_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'airport_event.dart';
part 'airport_state.dart';

class AirportBloc extends Bloc<AirportEvent, AirportState> {
  final AirportRepository _airportRepository;

  AirportBloc({required AirportRepository airportRepository})
      : _airportRepository = airportRepository,
        super(const AirportState()) {
    on<FetchAirportData>(_getAirports);
  }

  Future<void> _getAirports(
    AirportEvent event,
    Emitter<AirportState> emit,
  ) async {
    emit(state.copyWith(status: FetchAirportStatus.loading, airports: []));
    try {
      _airportRepository.setLimit("10");
      _airportRepository.setPage("1");
      final airports = await _airportRepository.getAirports();

      emit(state.copyWith(
        status: FetchAirportStatus.success,
        airports: airports,
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: FetchAirportStatus.failure, airports: []));
    }
  }
}
