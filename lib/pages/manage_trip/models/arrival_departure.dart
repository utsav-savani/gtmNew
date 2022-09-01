import 'package:flutter/material.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class ArrivalDepartureViewModel extends Equatable {
  final int index;
  final TripSchedulePrePayload tripSchedulePrePayload;
  final Widget arrrivalDepartureView;

  const ArrivalDepartureViewModel({
    required this.index,
    required this.tripSchedulePrePayload,
    required this.arrrivalDepartureView,
  });

  @override
  List<Object?> get props => [index, tripSchedulePrePayload, arrrivalDepartureView];
}
