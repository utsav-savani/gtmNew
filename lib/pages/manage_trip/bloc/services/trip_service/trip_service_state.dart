import 'package:trip_manager_repository/trip_manager_repository.dart';

enum FetchTripServiceStatus { initial, loading, success, failure, idle }

class TripServiceState extends Equatable {
  final FetchTripServiceStatus status;
  final TripServiceMain tripServiceMain;

  const TripServiceState({
    this.status = FetchTripServiceStatus.initial,
    this.tripServiceMain = const TripServiceMain(),
  });

  TripServiceState copyWith({
    FetchTripServiceStatus? status,
    required TripServiceMain tripServiceMain,
  }) {
    return TripServiceState(
      status: status ?? this.status,
      tripServiceMain: tripServiceMain,
    );
  }

  @override
  List<Object?> get props => [status, tripServiceMain];
}
