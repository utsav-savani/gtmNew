import 'dart:async';
import 'dart:developer';

import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'aircraft_event.dart';
part 'aircraft_state.dart';

class AircraftBloc extends Bloc<AircraftEvent, AircraftState> {
  final AircraftRepository _aircraftRepository;
  final List<Aircraft> _aircraft = [];
  final List<AircraftDetails> _aircraftDetails = [];

  AircraftRepository get aircraftRepository => _aircraftRepository;

  AircraftBloc({required AircraftRepository aircraftRepository})
      : _aircraftRepository = aircraftRepository,
        super(const AircraftState()) {
    on<FetchAircraftData>(_getAircraft);
    on<FetchDetailedAircraftEvent>(_getDetailedAircraft);
    on<SearchAircraft>(_searchAircraft);
    on<FetchSubAircraftData>(_getSubAircrafts);
    on<DownloadDocument>(_downloadDocument);
  }

  Future<void> _getAircraft(
    AircraftEvent event,
    Emitter<AircraftState> emit,
  ) async {
    emit(state.copyWith(status: FetchAircraftsStatus.loading, aircrafts: []));

    FetchAircraftData aircraftData = event as FetchAircraftData;
    if (aircraftData.customerID.isNotEmpty) {
      _aircraftRepository.setCustomerId(aircraftData.customerID);
    }

    try {
      final aircraft = await _aircraftRepository.getAircrafts();
      _aircraft.clear();
      _aircraft.addAll(aircraft);
      emit(state.copyWith(
        status: FetchAircraftsStatus.success,
        aircrafts: aircraft,
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: FetchAircraftsStatus.failure, aircrafts: []));
    }
  }

  Future<void> _getDetailedAircraft(
    AircraftEvent event,
    Emitter<AircraftState> emit,
  ) async {
    emit(state
        .copyWith(status: FetchAircraftsStatus.loading, aircraftDetails: []));

    FetchDetailedAircraftEvent aircraftData =
        event as FetchDetailedAircraftEvent;
    if (aircraftData.customerId.isNotEmpty) {
      _aircraftRepository.setCustomerId(aircraftData.customerId);
    }

    _aircraftRepository.setPage(event.page.toString());

    try {
      final aircraft = await _aircraftRepository.getDetailedAircrafts();
      _aircraftDetails.clear();
      _aircraftDetails.addAll(aircraft);
      emit(state.copyWith(
        status: FetchAircraftsStatus.success,
        aircraftDetails: aircraft,
      ));
    } catch (e) {
      log(e.toString());
      emit(state
          .copyWith(status: FetchAircraftsStatus.failure, aircraftDetails: []));
    }
  }

  void _searchAircraft(
    AircraftEvent event,
    Emitter<AircraftState> emit,
  ) {
    String searchText = '';
    SearchAircraft searchCountries = event as SearchAircraft;
    searchText = searchCountries.searchText.toLowerCase();
    if (searchText.isEmpty) {
      emit(state.copyWith(
          status: FetchAircraftsStatus.success,
          aircrafts: _aircraft,
          aircraftDetails: _aircraftDetails));
    } else {
      List<Aircraft> filteredCountries = _aircraft.where((element) {
        if (element.aircraftType != null) {
          return element.registrationNumber
                  .toLowerCase()
                  .contains(searchText) ||
              element.aircraftType!.fullName.toLowerCase().contains(searchText);
        } else {
          return element.registrationNumber.toLowerCase().contains(searchText);
        }
      }).toList();
      emit(state.copyWith(
        status: FetchAircraftsStatus.success,
        aircrafts: filteredCountries,
      ));
    }
  }

  Future<void> _getSubAircrafts(
    AircraftEvent event,
    Emitter<AircraftState> emit,
  ) async {
    emit(state.copyWith(status: FetchAircraftsStatus.loading, aircrafts: []));
    try {
      //TODO: Lokesh, please make this operator and aircraft id dynamic
      const int customerId = 679;
      const int aircraftId = 941;
      _aircraftRepository.setLimit("10");
      _aircraftRepository.setPage("1");
      final aircrafts = await _aircraftRepository.getSubAircrafts(
        aircraftId: aircraftId,
        customerId: customerId,
      );

      emit(state.copyWith(
        status: FetchAircraftsStatus.success,
        aircrafts: aircrafts,
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: FetchAircraftsStatus.failure, aircrafts: []));
    }
  }

  FutureOr<void> _downloadDocument(
      DownloadDocument event, Emitter<AircraftState> emit) async {
    await _aircraftRepository.downloadDocuments(event.docId);
    emit(state);
  }
}
