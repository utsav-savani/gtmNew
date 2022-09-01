// import 'dart:developer';

// import 'package:aircraft_repository/aircraft_repository.dart';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'paginated_aircraft_event.dart';
// part 'paginated_aircraft_state.dart';

// class PaginatedAircraftBloc
//     extends Bloc<PaginatedAircraftEvent, PaginatedAircraftState> {
//   final AircraftRepository _aircraftRepository;
//   final List<Aircraft> _aircraft = [];

//   AircraftRepository get aircraftRepository => _aircraftRepository;

//   PaginatedAircraftBloc({required AircraftRepository aircraftRepository})
//       : _aircraftRepository = aircraftRepository,
//         super(const PaginatedAircraftState()) {
//     on<FetchPaginatedAircraftData>(_getPaginatedAircraft);
//     //on<SearchAircraft>(_searchAircraft);
//     on<FetchSubAircraftData>(_getSubAircrafts);
//   }

//   Future<void> _getPaginatedAircraft(
//     PaginatedAircraftEvent event,
//     Emitter<PaginatedAircraftState> emit,
//   ) async {
//     emit(state.copyWith(
//         status: FetchAircraftsStatus.loading,
//         aircraft: AircraftData(0, const [])));

//     try {
//       final aircraft = await _aircraftRepository.getAircrafts();
//       // emit(state.copyWith(
//       //   status: FetchAircraftsStatus.success,
//       //   aircraft: ,
//       // ));
//     } catch (e) {
//       log(e.toString());
//       emit(state.copyWith(
//           status: FetchAircraftsStatus.failure,
//           aircraft: AircraftData(0, const [])));
//     }
//   }

//   // void _searchAircraft(
//   //   PaginatedAircraftEvent event,
//   //   Emitter<PaginatedAircraftState> emit,
//   // ) {
//   //   String searchText = '';
//   //   SearchAircraft searchCountries = event as SearchAircraft;
//   //   searchText = searchCountries.searchText.toLowerCase();
//   //   if (searchText.isEmpty) {
//   //     emit(state.copyWith(
//   //       status: FetchAircraftsStatus.success,
//   //       aircraft: AircraftData(0, const []),
//   //     ));
//   //   } else {
//   //     List<Aircraft> filteredCountries = _aircraft.where((element) {
//   //       if (element.aircraftType != null) {
//   //         return element.registrationNumber
//   //                 .toLowerCase()
//   //                 .contains(searchText) ||
//   //             element.aircraftType!.fullName.toLowerCase().contains(searchText);
//   //       } else {
//   //         return element.registrationNumber.toLowerCase().contains(searchText);
//   //       }
//   //     }).toList();
//   //     emit(state.copyWith(
//   //       status: FetchAircraftsStatus.success,
//   //       aircraft: AircraftData(filteredCountries.length, filteredCountries),
//   //     ));
//   //   }
//   // }

//   Future<void> _getSubAircrafts(
//     PaginatedAircraftEvent event,
//     Emitter<PaginatedAircraftState> emit,
//   ) async {
//     emit(state.copyWith(
//         status: FetchAircraftsStatus.loading,
//         aircraft: AircraftData(0, const [])));
//     try {
//       _aircraftRepository.setCustomerId("679");
//       _aircraftRepository.setAircraftId("941");
//       _aircraftRepository.setLimit("10");
//       _aircraftRepository.setPage("1");
//       final aircrafts = await _aircraftRepository.getSubAircrafts(
//           aircraftId: 941, customerId: 679);

//       emit(state.copyWith(
//         status: FetchAircraftsStatus.success,
//         aircraft: AircraftData(0, aircrafts),
//       ));
//     } catch (e) {
//       log(e.toString());
//       emit(state.copyWith(
//           status: FetchAircraftsStatus.failure,
//           aircraft: AircraftData(0, const [])));
//     }
//   }
// }
