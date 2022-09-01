import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripServiceModalPopupPayload extends Equatable {
  final String? serviceStatus;
  final String? payment;

  const TripServiceModalPopupPayload({
    this.serviceStatus,
    this.payment,
  });

  Map<String, dynamic> toJson() => {
        "serviceStatus": serviceStatus,
        "payment": payment,
      };

  @override
  List<Object?> get props => [serviceStatus, payment];
}
