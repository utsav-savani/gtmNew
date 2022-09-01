import 'package:trip_manager_repository/trip_manager_repository.dart';

enum TripCancelledSequenceStatus { initial, loading, success, failure }

class TripCancelledSequenceState extends Equatable {
  final TripCancelledSequenceStatus status;
  final List<TripSchedule> tripSchedules;

  const TripCancelledSequenceState({
    this.status = TripCancelledSequenceStatus.initial,
    this.tripSchedules = const [],
  });

  TripCancelledSequenceState copyWith({
    TripCancelledSequenceStatus? status,
    List<TripSchedule>? tripSchedules,
  }) {
    return TripCancelledSequenceState(
      status: status ?? this.status,
      tripSchedules: tripSchedules ?? [],
    );
  }

  @override
  List<Object?> get props => [status, tripSchedules];
}
