import 'package:equatable/equatable.dart';

abstract class CustomerAircraftEvent extends Equatable {
  const CustomerAircraftEvent();

  @override
  List<Object> get props => [];
}

class FetchCustomerAircraftData extends CustomerAircraftEvent {
  final int customerID;

  const FetchCustomerAircraftData(this.customerID);

  @override
  List<Object> get props => [customerID];
}
