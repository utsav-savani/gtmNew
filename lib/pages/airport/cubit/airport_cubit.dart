import 'package:airport_repository/airport_repository.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'airport_state.dart';

class AirportCubit extends Cubit<AirportState> {
  AirportCubit({required this.airportRepository}) : super(const AirportState());

  AirportRepository airportRepository;

  Future<void> getAirports() async {
    emit(state.copyWith(status: FetchAirportStatus.loading, airports: []));
    try {
      //  _airportRepository.setLimit("10");
      // _airportRepository.setPage("1");
      final airports = await airportRepository.getAirports();

      emit(state.copyWith(
        status: FetchAirportStatus.success,
        airports: airports,
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: FetchAirportStatus.failure, airports: []));
    }
  }

  Future<void> getAirportGeneralInfo(int airportId) async {
    emit(state.copyWith(airports: [], status: FetchAirportStatus.loading));
    try {
      final airportGeneralInfo = await airportRepository.getAirportGeneralInfo(airportId);
      emit(state.copyWith(airports: [], airportGeneralInfo: airportGeneralInfo, status: FetchAirportStatus.success));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(airports: [], status: FetchAirportStatus.failure));
    }
  }

  Future<void> getAirportPagination(bool forward) async {
    emit(state.copyWith(airports: [], status: FetchAirportStatus.loading));
    try {
      final airportsPaginated = await airportRepository.getAirportsPagination(forward);
      emit(state.copyWith(airports: airportsPaginated, airportGeneralInfo: null, status: FetchAirportStatus.success));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(airports: [], status: FetchAirportStatus.failure));
    }
  }

  Future<void> getAirportBySearch(String airportByName) async {
    emit(state.copyWith(airports: [], status: FetchAirportStatus.loading));
    try {
      final airportsPaginated = await airportRepository.getAirportByName(airportByName);
      emit(state.copyWith(airports: airportsPaginated, airportGeneralInfo: null, status: FetchAirportStatus.success));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(airports: [], status: FetchAirportStatus.failure));
    }
  }
}
