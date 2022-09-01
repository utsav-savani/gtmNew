import 'package:trip_manager_repository/trip_manager_repository.dart';

enum FetchPOBDetailsState { initial, loading, success, failure }

class POBDetailsState extends Equatable {
  final FetchPOBDetailsState status;
  final TripPobDetail pobDetail;

  const POBDetailsState({
    this.status = FetchPOBDetailsState.initial,
    this.pobDetail = const TripPobDetail(),
  });

  POBDetailsState copyWith({
    required FetchPOBDetailsState status,
    required TripPobDetail pobDetail,
  }) {
    return POBDetailsState(
      status: status,
      pobDetail: pobDetail,
    );
  }

  @override
  List<Object?> get props => [status, pobDetail];
}
