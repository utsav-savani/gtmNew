import 'package:trip_manager_repository/trip_manager_repository.dart';

abstract class TripCancelledSequenceEvent extends Equatable {
  const TripCancelledSequenceEvent();

  @override
  List<Object> get props => [];
}

class FetchCancelledSequence extends TripCancelledSequenceEvent {
  final int tripId;

  const FetchCancelledSequence({required this.tripId});

  @override
  List<Object> get props => [tripId];
}
