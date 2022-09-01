import 'package:airport_repository/airport_repository.dart';
import 'package:equatable/equatable.dart';

class AirportData extends Equatable {
  final int totalCount;
  final List<Airport> airports;

  AirportData(this.totalCount, this.airports);

  @override
  List<Object?> get props => [totalCount, airports];
}
