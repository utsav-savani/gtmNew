import 'package:gtm/pages/home/dashboard/bloc/trips/trip_bloc.dart';
import 'package:gtm/pages/home/dashboard/bloc/trips/trip_statistics_state.dart';
import 'package:gtm/pages/home/dashboard/dashboard_event.dart';
import 'package:intl/intl.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

enum TripStatisticType { total, completed, inProgress, draft, cancelled }

class TripStatisticBloc extends Bloc<DashboardEvent, TripStatisticsState> {
  static const String draft = 'draft',
      inProgress = 'inProgress',
      completed = 'completed',
      cancelled = 'cancelled';
  final TripManagerRepository _tripManagerRepository;

  TripStatisticBloc({required TripManagerRepository tripManagerRepository})
      : _tripManagerRepository = tripManagerRepository,
        super(const TripStatisticsState()) {
    on<FetchTripStatistics>(_fetchTripStatistics);
    on<FilterTripsByDate>(_filterTripsByDate);
    on<SearchTrips>(_searchTrips);
  }
  static final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  static const String searchBySchedule = 'SCHEDULE';
  static const String searchByCreated = 'CREATED';

  Future<void> _fetchTripStatistics(
    DashboardEvent event,
    Emitter<TripStatisticsState> emit,
  ) async {
    try {
      emit(
        const TripStatisticsState(
          status: FetchTripStatisticsStatus.loading,
          tripStatistic: TripStatistic(
            total: 0,
            completed: 0,
            inProgress: 0,
            draft: 0,
            cancelled: 0,
          ),
        ),
      );
      TripStatistic tripStatistics =
          await _tripManagerRepository.getTripStats();
      emit(
        TripStatisticsState(
          status: FetchTripStatisticsStatus.success,
          tripStatistic: tripStatistics,
        ),
      );
    } catch (e) {
      emit(
        const TripStatisticsState(
          status: FetchTripStatisticsStatus.failure,
          tripStatistic: TripStatistic(
            total: 0,
            completed: 0,
            inProgress: 0,
            draft: 0,
            cancelled: 0,
          ),
        ),
      );
    }
  }

  Future<void> _searchTrips(
    DashboardEvent event,
    Emitter<TripStatisticsState> emit,
  ) async {
    SearchTrips searchTrips = event as SearchTrips;
    try {
      _tripManagerRepository.setSearch(searchTrips.searchText);
      emit(
        const TripStatisticsState(
          status: FetchTripStatisticsStatus.loading,
          tripStatistic: TripStatistic(
            total: 0,
            completed: 0,
            inProgress: 0,
            draft: 0,
            cancelled: 0,
          ),
        ),
      );
      TripStatistic tripStatistics =
          await _tripManagerRepository.getTripStats();
      emit(
        TripStatisticsState(
          status: FetchTripStatisticsStatus.success,
          tripStatistic: tripStatistics,
        ),
      );
    } catch (e) {
      emit(
        const TripStatisticsState(
          status: FetchTripStatisticsStatus.failure,
          tripStatistic: TripStatistic(
            total: 0,
            completed: 0,
            inProgress: 0,
            draft: 0,
            cancelled: 0,
          ),
        ),
      );
    }
  }

  Future<void> _filterTripsByDate(
    DashboardEvent event,
    Emitter<TripStatisticsState> emit,
  ) async {
    FilterTripsByDate filterTrips = event as FilterTripsByDate;
    SearchBy searchBy = filterTrips.searchBy;
    DateTime? fromDate = filterTrips.fromDate;
    DateTime? toDate = filterTrips.toDate;
    try {
      switch (searchBy) {
        case SearchBy.schedule:
          _tripManagerRepository.setSearchBy(searchBySchedule);
          break;
        case SearchBy.created:
          _tripManagerRepository.setSearchBy(searchByCreated);
          break;
      }
      if (fromDate != null) {
        _tripManagerRepository.setFromDate(dateFormat.format(fromDate));
      }
      if (toDate != null) {
        _tripManagerRepository.setToDate(dateFormat.format(toDate));
      }
      emit(
        const TripStatisticsState(
          status: FetchTripStatisticsStatus.loading,
          tripStatistic: TripStatistic(
            total: 0,
            completed: 0,
            inProgress: 0,
            draft: 0,
            cancelled: 0,
          ),
        ),
      );
      TripStatistic tripStatistics =
          await _tripManagerRepository.getTripStats();
      emit(
        TripStatisticsState(
          status: FetchTripStatisticsStatus.success,
          tripStatistic: tripStatistics,
        ),
      );
    } catch (e) {
      emit(
        const TripStatisticsState(
          status: FetchTripStatisticsStatus.failure,
          tripStatistic: TripStatistic(
            total: 0,
            completed: 0,
            inProgress: 0,
            draft: 0,
            cancelled: 0,
          ),
        ),
      );
    }
  }
}
