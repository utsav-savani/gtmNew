import 'package:trip_manager_repository/trip_manager_repository.dart';

enum FetchPOBPersonsState { initial, loading, success, failure }

class POBPersonsState extends Equatable {
  final FetchPOBPersonsState status;
  final List<TripPerson> tripPersons;

  const POBPersonsState({
    this.status = FetchPOBPersonsState.initial,
    this.tripPersons = const [],
  });

  POBPersonsState copyWith({
    FetchPOBPersonsState? status,
    List<TripPerson>? tripPersons,
  }) {
    return POBPersonsState(
      status: status ?? this.status,
      tripPersons: tripPersons ?? [],
    );
  }

  @override
  List<Object?> get props => [status, tripPersons];
}
