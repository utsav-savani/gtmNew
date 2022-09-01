import 'package:trip_manager_repository/trip_manager_repository.dart';

abstract class TripDetailsEvent extends Equatable {
  const TripDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchTripDetails extends TripDetailsEvent {
  final String guid;

  const FetchTripDetails({required this.guid});

  @override
  List<Object> get props => [guid];
}

class SaveTripDetails extends TripDetailsEvent {
  final TripManagerPayload tripManagerPayload;

  const SaveTripDetails({required this.tripManagerPayload});

  @override
  List<Object> get props => [tripManagerPayload];
}
