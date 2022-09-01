part of 'home_bloc.dart';

enum FetchTripsStatus { initial, loading, success, failure }
enum DataTableStatus { initial, loading, success, failure }
//enum AdvanceFilterStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  const HomeState();

  /*  final FetchTripsStatus status;
  final DataTableSource? dataTableSource;
  final List<Trip>? trips;
  final TripStatistic? tripStatistic;

  const HomeState({
    this.status = FetchTripsStatus.initial,
    this.dataTableSource,
    this.trips,
    this.tripStatistic,
  });

  HomeState copyWith({
    FetchTripsStatus? status,
    List<Trip>? trips,
    TripStatistic? tripStatistic,
    DataTableSource? dataTableSource,
  }) {
    return HomeState(
        status: status ?? this.status,
        trips: trips,
        tripStatistic: tripStatistic,
        dataTableSource: dataTableSource ?? this.dataTableSource);
  }
 */
  //bool get isNewTrip => trips == null;

  @override
  List<Object?> get props => [/* status, trips, tripStatistic, dataTableSource */];
}
/* 
class AdvanceFilterState extends HomeState {
  final TripManagerFilter? filter;
  final List<Trip>? tripList;
  final AdvanceFilterStatus? status;

  const AdvanceFilterState({required this.filter, this.tripList, this.status});

  AdvanceFilterState copywith({
    TripManagerFilter? filter,
    List<Trip>? tripList,
    AdvanceFilterStatus? status,
  }) {
    return AdvanceFilterState(
      filter: filter ?? this.filter,
      tripList: tripList ?? this.tripList,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [filter!, tripList!, status!];
} */

class HomeInitial extends HomeState {}

class DashboardSuccess extends HomeState {
  const DashboardSuccess(
      this.dataTableSource, this.tripStatistic, this.tripList, this.isUpdateStats, this.selectedCard);
  final TripDataTable dataTableSource;
  final TripStatistic tripStatistic;
  final List<Trip> tripList;
  final bool? isUpdateStats;
  final String? selectedCard;
  @override
  List<Object> get props => [dataTableSource, tripStatistic, tripList];
}

class DashboardLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class DashboardFailure extends HomeState {
  @override
  List<Object> get props => [];
}

class DataTableLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class DataTableSuccess extends HomeState {
  final TripDataTable dataTableSource;

  const DataTableSuccess(this.dataTableSource);

  @override
  List<Object> get props => [dataTableSource];
}

class DataTableFailure extends HomeState {
  @override
  List<Object> get props => [];
}

class InitialDraftTripLoading extends HomeState {
  const InitialDraftTripLoading();
  @override
  List<Object> get props => [];
}

class InitialDraftTripSuccess extends HomeState {
  final List<Office> offices;
  final List<Aircraft> aircrafts;
  final List<Customer> customers;

  const InitialDraftTripSuccess(
    this.offices,
    this.aircrafts,
    this.customers,
  );

  @override
  List<Object> get props => [
        offices,
        aircrafts,
        customers,
      ];
}

class InitialDraftTripFailure extends HomeState {
  const InitialDraftTripFailure(this.failedMessage);
  final String failedMessage;
  @override
  List<Object> get props => [failedMessage];
}

class CreateTripStateSuccess extends HomeState {
  final TripDataResponse tripDataResponse;

  const CreateTripStateSuccess(this.tripDataResponse);

  @override
  List<Object> get props => [tripDataResponse];
}

class CreateTripStateLoading extends HomeState {
  const CreateTripStateLoading();

  @override
  List<Object> get props => [];
}

class OperatorLoading extends HomeState {
  const OperatorLoading();

  @override
  List<Object> get props => [];
}

class OperatorSuccess extends HomeState {
  const OperatorSuccess(this.operators);
  final List<Operator> operators;
  @override
  List<Object> get props => [operators];
}

class OperatorFailure extends HomeState {
  const OperatorFailure(this.operatorFailedMessage);
  final String operatorFailedMessage;
  @override
  List<Object> get props => [operatorFailedMessage];
}

class CreateTripStateFailure extends HomeState {
  const CreateTripStateFailure(this.failedMessage);

  final String failedMessage;

  @override
  List<Object> get props => [failedMessage];
}

class FlightCategoryLoading extends HomeState {
  const FlightCategoryLoading();

  @override
  List<Object> get props => [];
}

class FlightCategorySuccess extends HomeState {
  const FlightCategorySuccess(this.flightCategory);
  final List<FlightCategory> flightCategory;
  @override
  List<Object> get props => [flightCategory];
}

class FlightCategoryFailure extends HomeState {
  const FlightCategoryFailure(this.flightCategoryFailureFailedMessage);
  final String flightCategoryFailureFailedMessage;
  @override
  List<Object> get props => [flightCategoryFailureFailedMessage];
}
