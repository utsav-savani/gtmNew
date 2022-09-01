import 'package:gtm/pages/home/dashboard/bloc/trips/trip_state.dart';
import 'package:gtm/pages/home/dashboard/bloc/trips/trip_statistics_bloc.dart';
import 'package:gtm/pages/home/dashboard/dashboard_event.dart';
import 'package:intl/intl.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

enum SearchBy { schedule, created }

enum Period { today, yesterday, next7days, next30Days, currentMonth, previousMonth }

class TripBloc extends Bloc<DashboardEvent, TripListState> {
  final TripManagerRepository _tripManagerRepository;
  static final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  static const String searchBySchedule = 'SCHEDULE';
  static const String searchByCreated = 'CREATED';
  static const String total = 'Total', draft = 'Draft', inProgress = 'In Progress', completed = 'Completed', cancelled = 'Cancelled';
  static const int limit = 50;
  int _page = 1;
  int totalCount = 0;

  TripBloc({required TripManagerRepository tripManagerRepository})
      : _tripManagerRepository = tripManagerRepository,
        super(const TripListState()) {
    on<FetchTrips>(_fetchTrips);
    on<SearchTrips>(_searchTrips);
    on<FilterTripsByDate>(_filterTripsByDate);
    on<FilterByTripStatistics>(_filterByStatus);
    //on<LoadMore>(_loadMore);
  }

  Future<List<Trip>> loadMore() async {
    try {
      _page = _page + 1;
      _tripManagerRepository.setPage(_page);
      return await _tripManagerRepository.getTrips();
    } catch (e) {
      return [];
    }
  }

  Future<void> _fetchTrips(
    DashboardEvent event,
    Emitter<TripListState> emit,
  ) async {
    try {
      emit(const TripListState(status: FetchTripStatus.loading, trips: []));
      _resetToFirstPage();
      List<Trip> trips = await _tripManagerRepository.getTrips();
      emit(TripListState(status: FetchTripStatus.success, trips: trips));
    } catch (e) {
      emit(const TripListState(status: FetchTripStatus.failure, trips: []));
    }
  }

  Future<void> _searchTrips(
    DashboardEvent event,
    Emitter<TripListState> emit,
  ) async {
    SearchTrips searchTrips = event as SearchTrips;
    try {
      _tripManagerRepository.setSearch(searchTrips.searchText);
      emit(const TripListState(status: FetchTripStatus.loading, trips: []));
      _resetToFirstPage();
      List<Trip> trips = await _tripManagerRepository.getTrips();
      emit(TripListState(status: FetchTripStatus.success, trips: trips));
    } catch (e) {
      emit(const TripListState(status: FetchTripStatus.failure, trips: []));
    }
  }

  Future<void> _filterTripsByDate(
    DashboardEvent event,
    Emitter<TripListState> emit,
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
      emit(const TripListState(status: FetchTripStatus.loading, trips: []));
      _resetToFirstPage();
      List<Trip> trips = await _tripManagerRepository.getTrips();
      emit(TripListState(status: FetchTripStatus.success, trips: trips));
    } catch (e) {
      emit(const TripListState(status: FetchTripStatus.failure, trips: []));
    }
  }

  Future<void> _filterByStatus(
    DashboardEvent event,
    Emitter<TripListState> emit,
  ) async {
    try {
      FilterByTripStatistics filterByTripStatistics = event as FilterByTripStatistics;
      switch (filterByTripStatistics.tripStatisticType) {
        case TripStatisticType.total:
          _tripManagerRepository.setStatus('');
          break;
        case TripStatisticType.completed:
          _tripManagerRepository.setStatus(TripStatisticBloc.completed);
          break;
        case TripStatisticType.inProgress:
          _tripManagerRepository.setStatus(TripStatisticBloc.inProgress);
          break;
        case TripStatisticType.draft:
          _tripManagerRepository.setStatus(TripStatisticBloc.draft);
          break;
        case TripStatisticType.cancelled:
          _tripManagerRepository.setStatus(TripStatisticBloc.cancelled);
          break;
      }
      emit(const TripListState(status: FetchTripStatus.loading, trips: []));
      _resetToFirstPage();
      List<Trip> trips = await _tripManagerRepository.getTrips();
      print('Trip count' + trips.length.toString());
      emit(TripListState(status: FetchTripStatus.success, trips: trips));
    } catch (e) {
      emit(const TripListState(status: FetchTripStatus.failure, trips: []));
    }
  }

  // Future<void> _loadMore(
  //   DashboardEvent event,
  //   Emitter<TripListState> emit,
  // ) async {
  //   LoadMore loadMore = DashboardEvent as LoadMore;
  //   final int itemPosition = loadMore.index + 1;
  //   final bool requestMoreData =
  //       itemPosition % rowsPerPage == 0 && itemPosition != 0;
  //   final int pageToRequest = itemPosition ~/ rowsPerPage;
  //   if (requestMoreData && pageToRequest + 1 >= _page) {
  //     _setOrResetToFirstPage(setPage: _page);
  //     PagedTripData pagedTripData =
  //         await _tripManagerRepository.getTripsWithTotalCount();
  //     _page = _page + 1;
  //     emit(TripListState(
  //         status: FetchTripStatus.success, trips: pagedTripData.trips));
  //   }
  // }

  // void _createTrip() {}

  void _resetToFirstPage() {
    _page = 1;
    _tripManagerRepository.setPage(_page);
    _tripManagerRepository.setLimit(limit);
  }

  static String getSearchByString(SearchBy searchBy) {
    switch (searchBy) {
      case SearchBy.schedule:
        return 'Schedule';
      case SearchBy.created:
        return 'Created';
    }
  }

  static String getPeriodString(Period period) {
    switch (period) {
      case Period.today:
        return 'Today';
      case Period.yesterday:
        return 'Yesterday';
      case Period.next7days:
        return 'Next 7 days';
      case Period.next30Days:
        return 'Next 30 days';
      case Period.currentMonth:
        return 'Current Month';
      case Period.previousMonth:
        return 'Previous Month';
    }
  }
}
