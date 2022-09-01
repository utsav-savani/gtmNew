part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchTripData extends HomeEvent {
  /*  const FetchTripData(this.trips, this.tripStatistic);
  final List<Trip> trips;
  final TripStatistic tripStatistic; */

  @override
  List<Object> get props => [/* trips, tripStatistic */];
}

class FetchTripDataLoading extends HomeEvent {
  @override
  List<Object> get props => [];
}

class SaveUserDetails extends HomeEvent {
  @override
  List<Object> get props => [];
}

class LoadTripDataTable extends HomeEvent {
  const LoadTripDataTable(this.tripList, this.context);

  final List<Trip> tripList;
  final BuildContext context;
  @override
  List<Object> get props => [tripList];
}

class FilterAdavnceEvent extends HomeEvent {
  final TripManagerFilter filter;
  final bool? updateStats;
  final String? selectedCard;
  final TripStatistic? statistic;

  const FilterAdavnceEvent(
      this.filter, this.updateStats, this.selectedCard, this.statistic);

  @override
  List<Object> get props => [filter];
}

class SortByColumnName extends HomeEvent {
  const SortByColumnName(this.trip, this.column, this.order);
  final int column;
  final bool order;
  final String trip;

  @override
  List<Object> get props => [trip, column, order];
}

class InitiateTripDraftEvent extends HomeEvent {
  // final List<Office> offices;
  // final List<Aircraft> aircrafts;
  // final List<Customer> customers;
  // final List<FlightCategory> flightCategories;

  const InitiateTripDraftEvent(
      // this.offices,
      // this.aircrafts,
      // this.customers,
      // this.flightCategories,
      );

  @override
  List<Object> get props => [
        // offices,
        // aircrafts,
        // customers,
        // flightCategories,
      ];
}

class GetOperatorEvent extends HomeEvent {
  final String aircraftId;
  const GetOperatorEvent(this.aircraftId);

  @override
  List<Object> get props => [aircraftId];
}

class GetFlightCategoryEvent extends HomeEvent {
  final String customerId;
  const GetFlightCategoryEvent(this.customerId);

  @override
  List<Object> get props => [customerId];
}

class CreateTripEvent extends HomeEvent {
  final Aircraft selectedAircraft;
  final FlightCategory selectedFlightCategory;
  final Office selectedOffice;
  final int selectedCustomerId;
  final Operator selectedOperator;
  final bool tripCostEstimate;
  final String customerReference;

  const CreateTripEvent(
    this.selectedAircraft,
    this.selectedFlightCategory,
    this.selectedOffice,
    this.selectedCustomerId,
    this.selectedOperator,
    this.tripCostEstimate,
    this.customerReference,
  );

  @override
  List<Object> get props => [
        selectedAircraft,
        selectedFlightCategory,
        selectedOffice,
        selectedCustomerId,
        selectedOperator,
        tripCostEstimate,
        customerReference,
      ];
}
