import 'package:flight_category_repository/flight_category_repository.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

enum FetchTripScheduleListState { initial, loading, success, failure }

class TripScheduleListState extends Equatable {
  final FetchTripScheduleListState status;
  final List<TripSchedulePrePayload> tripScheduleList;
  final List<FlightCategory> categories;

  const TripScheduleListState({
    this.status = FetchTripScheduleListState.initial,
    this.tripScheduleList = const [],
    this.categories = const [],
  });

  TripScheduleListState copyWith({
    FetchTripScheduleListState? status,
    List<TripSchedulePrePayload>? tripScheduleList,
    List<FlightCategory>? categories,
  }) {
    return TripScheduleListState(
      status: status ?? this.status,
      tripScheduleList: tripScheduleList ?? [],
      categories: categories ?? [],
    );
  }

  @override
  List<Object?> get props => [status, tripScheduleList, categories];
}

class FlightCategoryLoading extends TripScheduleListState {
  const FlightCategoryLoading();

  @override
  List<Object> get props => [];
}

class FlightCategorySuccess extends TripScheduleListState {
  const FlightCategorySuccess(this.flightCategory);
  final List<FlightCategory> flightCategory;
  @override
  List<Object> get props => [flightCategory];
}

class FlightCategoryFailure extends TripScheduleListState {
  const FlightCategoryFailure(this.flightCategoryFailureFailedMessage);
  final String flightCategoryFailureFailedMessage;
  @override
  List<Object> get props => [flightCategoryFailureFailedMessage];
}
