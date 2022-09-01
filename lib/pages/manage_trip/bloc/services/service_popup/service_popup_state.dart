import 'package:trip_manager_repository/trip_manager_repository.dart';

enum FetchSchedulePopupStatus { initial, loading, success, failure }

class ServicePopupState extends Equatable {
  final FetchSchedulePopupStatus status;
  final TripModalPopupDetail tripPopupDetail;

  const ServicePopupState({
    this.status = FetchSchedulePopupStatus.initial,
    this.tripPopupDetail = const TripModalPopupDetail(),
  });

  ServicePopupState copyWith({
    FetchSchedulePopupStatus? status,
    required TripModalPopupDetail tripPopupDetail,
  }) {
    return ServicePopupState(
      status: status ?? this.status,
      tripPopupDetail: tripPopupDetail,
    );
  }

  @override
  List<Object?> get props => [status, tripPopupDetail];
}
