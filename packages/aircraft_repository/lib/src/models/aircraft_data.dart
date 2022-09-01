import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:equatable/equatable.dart';

class AircraftData extends Equatable {
  final int totalCount;
  final List<AircraftDetails> aircraftDetails;

  AircraftData(this.totalCount, this.aircraftDetails);

  @override
  List<Object?> get props => [totalCount, this.aircraftDetails];
}
