import 'package:trip_manager_repository/trip_manager_repository.dart';

enum FetchTripStatus { initial, loading, success, failure }

class TripListState extends Equatable {
  final FetchTripStatus status;
  final List<Trip>? trips;

  const TripListState({
    this.status = FetchTripStatus.initial,
    this.trips,
  });

  TripListState copyWith({
    FetchTripStatus? status,
    required List<Trip> trips,
  }) {
    return TripListState(
      status: status ?? this.status,
      trips: trips,
    );
  }

  @override
  List<Object?> get props => [status, trips];
}