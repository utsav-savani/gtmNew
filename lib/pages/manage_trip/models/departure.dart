import 'package:flutter/material.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class DepartureViewModel extends Equatable {
  final int index;
  final Widget departureView;
  final TripSchedulePrePayload tripSchedulePrePayload;

  const DepartureViewModel({
    required this.index,
    required this.departureView,
    required this.tripSchedulePrePayload,
  });

  @override
  List<Object?> get props => [index, departureView, tripSchedulePrePayload];
}
