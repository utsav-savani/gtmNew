part of 'paginated_airport_bloc.dart';

abstract class PaginatedAirportEvent extends Equatable {
  const PaginatedAirportEvent();

  @override
  List<Object> get props => [];
}

class FetchPaginatedAirportData extends PaginatedAirportEvent {
  final Map<String,dynamic>? airports;

  const FetchPaginatedAirportData({this.airports});

  @override
  List<Object> get props => [airports!];
}


