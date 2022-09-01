
import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:equatable/equatable.dart';

enum FetchSubAircraftStatus { initial, loading, success, failure }

class SubAircraftState extends Equatable {
  final FetchSubAircraftStatus status;
  final List<Aircraft>? aircrafts;

  const SubAircraftState({
    this.status = FetchSubAircraftStatus.initial,
    this.aircrafts,
  });

  SubAircraftState copyWith({
    FetchSubAircraftStatus? status,
    required List<Aircraft> aircrafts,
  }) {
    return SubAircraftState(
      status: status ?? this.status,
      aircrafts: aircrafts,
    );
  }

  @override
  List<Object?> get props => [status, aircrafts];
}
