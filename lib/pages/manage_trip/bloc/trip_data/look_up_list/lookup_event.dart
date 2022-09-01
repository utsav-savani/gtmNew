import 'package:trip_manager_repository/trip_manager_repository.dart';

abstract class LookupEvent extends Equatable {
  const LookupEvent();

  @override
  List<Object> get props => [];
}

class FetchLookupList extends LookupEvent {
  final int customerId;

  const FetchLookupList({this.customerId = 0});

  @override
  List<Object> get props => [customerId];
}

class SearchLookupList extends LookupEvent {
  final String searchText;

  const SearchLookupList({this.searchText = '0'});

  @override
  List<Object> get props => [searchText];
}

class SaveLookupData extends LookupEvent {
  final TripLookUpPayload tripLookUpPayload;

  const SaveLookupData({this.tripLookUpPayload = const TripLookUpPayload(customercontactId:  0, guid:  0)});

  @override
  List<Object> get props => [tripLookUpPayload];
}
