import 'package:trip_manager_repository/trip_manager_repository.dart';

enum FetchPOBListState { initial, loading, success, failure }

class POBListState extends Equatable {
  final FetchPOBListState status;
  final TripPobScheduleMain? tripPOBListSchedule;

  const POBListState({
    this.status = FetchPOBListState.initial,
    this.tripPOBListSchedule,
  });

  POBListState copyWith({
    FetchPOBListState? status,
    TripPobScheduleMain? tripPOBListSchedule,
  }) {
    return POBListState(
      status: status ?? this.status,
      tripPOBListSchedule: tripPOBListSchedule,
    );
  }

  @override
  List<Object?> get props => [status, tripPOBListSchedule];
}
