import 'package:equatable/equatable.dart';

abstract class SubAircraftEvent extends Equatable {
  const SubAircraftEvent();

  @override
  List<Object> get props => [];
}

class FetchCustomerSubAircraftData extends SubAircraftEvent {
  final int aircraftID;
  final int customerID;

  const FetchCustomerSubAircraftData(this.aircraftID,this.customerID);

  @override
  List<Object> get props => [aircraftID];
}
