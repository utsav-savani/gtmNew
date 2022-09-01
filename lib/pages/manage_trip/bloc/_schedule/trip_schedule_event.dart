import 'package:trip_manager_repository/trip_manager_repository.dart';

abstract class TripScheduleListEvent extends Equatable {
  const TripScheduleListEvent();

  @override
  List<Object> get props => [];
}

class FetchScheduleList extends TripScheduleListEvent {
  final int? tripId;

  const FetchScheduleList({this.tripId});

  @override
  List<Object> get props => [tripId!];
}

class GetFlightCategoryEvent extends TripScheduleListEvent {
  final String customerId;
  const GetFlightCategoryEvent(this.customerId);

  @override
  List<Object> get props => [customerId];
}

class AirportListEvent extends TripScheduleListEvent {
  const AirportListEvent();

  @override
  List<Object> get props => [];
}
