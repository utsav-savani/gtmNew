part of 'aircraft_bloc.dart';

abstract class AircraftEvent extends Equatable {
  const AircraftEvent();

  @override
  List<Object> get props => [];
}

class FetchAircraftData extends AircraftEvent {
  final List<Aircraft>? aircrafts;
  final String customerID;

  const FetchAircraftData({this.customerID = '', this.aircrafts});

  @override
  List<Object> get props => [aircrafts!];
}

class FetchDetailedAircraftEvent extends AircraftEvent {
  final int page;
  final String customerId;

  const FetchDetailedAircraftEvent({
    this.page = 0,
    this.customerId = '',
  });

  @override
  List<Object> get props => [customerId, page];
}

class SearchAircraft extends AircraftEvent {
  final String searchText;

  const SearchAircraft({this.searchText = ''});

  @override
  List<Object> get props => [searchText];
}

class FetchAircraftDetail extends AircraftEvent {
  final int airCraftId;
  const FetchAircraftDetail({required this.airCraftId});
  @override
  List<Object> get props => [airCraftId];
}

class FetchSubAircraftData extends AircraftEvent {
  final List<Aircraft>? aircrafts;

  const FetchSubAircraftData({this.aircrafts});

  @override
  List<Object> get props => [aircrafts!];
}

class DownloadDocument extends AircraftEvent {
  final int docId;

  const DownloadDocument(this.docId);
}
