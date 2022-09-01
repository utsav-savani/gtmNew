part of 'trips_bloc.dart';

abstract class TripsEvent extends Equatable {
  const TripsEvent();

  @override
  List<Object> get props => [];
}

class FetchTripList extends TripsEvent {
  final int aircraftId;
  final int page;

  const FetchTripList({required this.aircraftId, this.page = 0});

  @override
  List<Object> get props => [aircraftId, page];
}
