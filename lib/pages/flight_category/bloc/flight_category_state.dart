part of 'flight_category_bloc.dart';

enum FetchCategoriesStatus { initial, loading, success, failure }

class FlightCategoryState extends Equatable {
  final FetchCategoriesStatus status;
  final List<FlightCategory>? flightcategories;

  const FlightCategoryState({
    this.status = FetchCategoriesStatus.initial,
    this.flightcategories,
  });

  FlightCategoryState copyWith({
    FetchCategoriesStatus? status,
    required List<FlightCategory> flightcategories,
  }) {
    return FlightCategoryState(
      status: status ?? this.status,
      flightcategories: flightcategories,
    );
  }

  @override
  List<Object?> get props => [status, flightcategories];
}
