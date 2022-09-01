import 'package:trip_manager_repository/src/models/_pob/unknown_persons.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

abstract class POBEvent extends Equatable {
  const POBEvent();

  @override
  List<Object> get props => [];
}

class FetchPOBList extends POBEvent {
  final String guid;

  const FetchPOBList({this.guid = ''});

  @override
  List<Object> get props => [guid];
}

class FetchPOBDetails extends POBEvent {
  final int personID;

  const FetchPOBDetails({required this.personID});

  @override
  List<Object> get props => [personID];
}

class FilterPOBList extends POBEvent {
  final int tripScheduleID;
  final String filterText;

  const FilterPOBList({this.filterText = '', this.tripScheduleID = 0});

  @override
  List<Object> get props => [filterText];
}

class SearchPOBList extends POBEvent {
  final int tripScheduleID;
  final String searchText;

  const SearchPOBList({this.searchText = '', this.tripScheduleID = 0});

  @override
  List<Object> get props => [searchText];
}

class FetchPOBPersons extends POBEvent {
  final String guid;

  const FetchPOBPersons({this.guid = ''});

  @override
  List<Object> get props => [guid];
}

class DeletePOBSequence extends POBEvent {
  final int tripPobId;

  const DeletePOBSequence({this.tripPobId = 0});

  @override
  List<Object> get props => [tripPobId];
}

class EditPersonPassportSequence extends POBEvent {
  final int personID;
  final int personPassportDocumentID;
  final List<Map<String, dynamic>> selectedAirports;

  const EditPersonPassportSequence({this.personID = 0, this.personPassportDocumentID = 0, this.selectedAirports = const []});

  @override
  List<Object> get props => [personID, personPassportDocumentID, selectedAirports];
}

class SavePOBScheduleDetails extends POBEvent {
  final List<SavePOBScheduleDetailsPayload> podScheduleDetails;

  const SavePOBScheduleDetails({this.podScheduleDetails = const []});

  @override
  List<Object> get props => [podScheduleDetails];
}

class SavePOBDetails extends POBEvent {
  final List<UnknownPersons> unknownPersons;

  const SavePOBDetails({this.unknownPersons = const []});

  @override
  List<Object> get props => [unknownPersons];
}

class DownloadReport extends POBEvent {
  final String guid;
  final TripPobSchedule pob;
  final TripPobOffice office;

  const DownloadReport({required this.guid, required this.pob, required this.office});

  @override
  List<Object> get props => [guid, pob, office];
}

class ResetPOBState extends POBEvent {
  const ResetPOBState();
}
