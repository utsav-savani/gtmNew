import 'package:flutter/material.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class ArrivalViewModel extends Equatable {
  final int index;
  final Widget arrivalView;
  final TripSchedulePrePayload tripSchedulePrePayload;

  const ArrivalViewModel({
    required this.index,
    required this.arrivalView,
    required this.tripSchedulePrePayload,
  });

  @override
  List<Object?> get props => [index, arrivalView, tripSchedulePrePayload];
}
