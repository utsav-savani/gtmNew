part of 'flight_category_bloc.dart';

abstract class FlightCategoryEvent extends Equatable {
  const FlightCategoryEvent();

  @override
  List<Object> get props => [];
}

class FetchFlightCategoryData extends FlightCategoryEvent {
  final int customerID;
  final List<FlightCategory>? flightcategories;

  const FetchFlightCategoryData({this.customerID=0,this.flightcategories});

  @override
  List<Object> get props => [flightcategories!];
}
