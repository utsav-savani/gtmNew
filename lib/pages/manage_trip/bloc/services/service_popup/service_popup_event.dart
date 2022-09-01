import 'package:equatable/equatable.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

abstract class ServicePopupEvent extends Equatable {
  const ServicePopupEvent();

  @override
  List<Object> get props => [];
}

class FetchTripPopup extends ServicePopupEvent {
  final TripServiceModalType type;
  final int typeId;

  const FetchTripPopup({this.type = TripServiceModalType.LOCATION, this.typeId = 0});

  @override
  List<Object> get props => [type, typeId];
}

class SavePopup extends ServicePopupEvent {
  final TripServiceModalType type;
  final int serviceId;
  final TripServiceModalPopupPayload tripServiceModalPopupPayload;

  const SavePopup({required this.type, required this.serviceId, required this.tripServiceModalPopupPayload});

  @override
  List<Object> get props => [type, serviceId,tripServiceModalPopupPayload];

}
