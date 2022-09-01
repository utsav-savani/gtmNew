import 'package:gtm/pages/home/dashboard/bloc/trips/trip_bloc.dart';
import 'package:gtm/pages/home/dashboard/bloc/trips/trip_statistics_bloc.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class FetchTrips extends DashboardEvent {
  const FetchTrips();

  @override
  List<Object> get props => [];
}

class SearchTrips extends DashboardEvent {
  final String searchText;

  const SearchTrips({this.searchText = ''});

  @override
  List<Object> get props => [searchText];
}

class FilterTripsByDate extends DashboardEvent {
  final SearchBy searchBy;
  final DateTime? fromDate;
  final DateTime? toDate;

  const FilterTripsByDate({required this.searchBy, this.fromDate, this.toDate});

  @override
  List<Object> get props => [searchBy];
}

class FilterByTripStatistics extends DashboardEvent {
  final TripStatisticType tripStatisticType;

  const FilterByTripStatistics({required this.tripStatisticType});

  @override
  List<Object> get props => [tripStatisticType];
}

class FetchTripStatistics extends DashboardEvent {
  const FetchTripStatistics();

  @override
  List<Object> get props => [];
}

class LoadMore extends DashboardEvent {
  final int index;

  const LoadMore({required this.index});

  @override
  List<Object> get props => [index];
}
