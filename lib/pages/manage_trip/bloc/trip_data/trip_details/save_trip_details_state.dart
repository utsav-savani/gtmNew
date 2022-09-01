import 'package:trip_manager_repository/trip_manager_repository.dart';

enum SaveTripDetailsStatus { initial, loading, success, failure }

class SaveTripDetailsState extends Equatable {
  final SaveTripDetailsStatus status;
  final TripDataResponse tripDataResponse;

  const SaveTripDetailsState({
    this.status = SaveTripDetailsStatus.initial,
    required this.tripDataResponse,
  });

  SaveTripDetailsState copyWith({
    SaveTripDetailsStatus? status,
    TripDataResponse? tripDataResponse,
  }) {
    return SaveTripDetailsState(
      status: status ?? this.status,
      tripDataResponse: tripDataResponse??TripDataResponse.inital(),
    );
  }

  @override
  List<Object?> get props => [status, tripDataResponse];
}
