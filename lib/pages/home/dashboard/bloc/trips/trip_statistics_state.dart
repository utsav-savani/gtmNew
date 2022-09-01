import 'package:trip_manager_repository/trip_manager_repository.dart';

enum FetchTripStatisticsStatus { initial, loading, success, failure }

class TripStatisticsState extends Equatable {
  final FetchTripStatisticsStatus status;
  final TripStatistic? tripStatistic;

  const TripStatisticsState({
    this.status = FetchTripStatisticsStatus.initial,
    this.tripStatistic,
  });

  TripStatisticsState copyWith({
    FetchTripStatisticsStatus? status,
    required TripStatistic? tripStatistic,
  }) {
    return TripStatisticsState(
      status: status ?? this.status,
      tripStatistic: tripStatistic,
    );
  }

  @override
  List<Object?> get props => [status, tripStatistic];
}