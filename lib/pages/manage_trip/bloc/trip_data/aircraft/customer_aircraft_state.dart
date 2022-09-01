
import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:equatable/equatable.dart';

enum FetchCustomerAircraftStatus { initial, loading, success, failure }

class CustomerAircraftState extends Equatable {
  final FetchCustomerAircraftStatus status;
  final List<Aircraft>? aircrafts;

  const CustomerAircraftState({
    this.status = FetchCustomerAircraftStatus.initial,
    this.aircrafts,
  });

  CustomerAircraftState copyWith({
    FetchCustomerAircraftStatus? status,
    required List<Aircraft> aircrafts,
  }) {
    return CustomerAircraftState(
      status: status ?? this.status,
      aircrafts: aircrafts,
    );
  }

  @override
  List<Object?> get props => [status, aircrafts];
}
