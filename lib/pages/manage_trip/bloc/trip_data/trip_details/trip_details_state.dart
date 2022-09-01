import 'package:trip_manager_repository/trip_manager_repository.dart';

enum FetchTripDetailsStatus { initial, loading, success, failure }

class FetchTripDetailsState extends Equatable {
  final FetchTripDetailsStatus status;
  final TripDetail tripDetail;

  const FetchTripDetailsState({
    this.status = FetchTripDetailsStatus.initial,
    required this.tripDetail,
  });

  FetchTripDetailsState copyWith({
    FetchTripDetailsStatus? status,
    required TripDetail tripDetail,
  }) {
    return FetchTripDetailsState(
      status: status ?? this.status,
      tripDetail: tripDetail,
    );
  }

  @override
  List<Object?> get props => [status, tripDetail];

}
