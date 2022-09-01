part of 'airport_bloc.dart';

abstract class AirportEvent extends Equatable {
  const AirportEvent();

  @override
  List<Object> get props => [];
}

class FetchAirportData extends AirportEvent {
  final List<Airport>? airports;

  const FetchAirportData({this.airports});

  @override
  List<Object> get props => [airports!];
}


