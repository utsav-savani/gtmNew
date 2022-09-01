import 'package:trip_manager_repository/trip_manager_repository.dart';

enum FetchLookupListState { initial, loading, success, failure }

class LookupListState extends Equatable {
  final FetchLookupListState status;
  final List<TripPOCContact> lookupList;

  const LookupListState({
    this.status = FetchLookupListState.initial,
    this.lookupList = const [],
  });

  LookupListState copyWith({
    FetchLookupListState? status,
    required List<TripPOCContact> lookupList,
  }) {
    return LookupListState(
      status: status ?? this.status,
      lookupList: lookupList,
    );
  }

  @override
  List<Object?> get props => [status, lookupList];

}
