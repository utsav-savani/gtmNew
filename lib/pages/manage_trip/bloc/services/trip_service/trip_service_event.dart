import 'package:trip_manager_repository/trip_manager_repository.dart';

abstract class TripServiceEvent extends Equatable {
  const TripServiceEvent();

  @override
  List<Object> get props => [];
}

class FetchTripService extends TripServiceEvent {
  final String guid;

  const FetchTripService({this.guid = ''});

  @override
  List<Object> get props => [guid];
}

class DeleteTripService extends TripServiceEvent {
  final int tripServiceID;
  final int tripServiceScheduleID;
  final int tripOverflyID;
  final bool isOverFlight;

  const DeleteTripService({
    this.tripServiceID = 0,
    this.tripServiceScheduleID = 0,
    required this.tripOverflyID,
    required this.isOverFlight,
  });

  @override
  List<Object> get props => [
        tripServiceID,
        tripServiceScheduleID,
        tripOverflyID,
        isOverFlight,
      ];
}

class AddTripService extends TripServiceEvent {
  final int tripServiceID;
  final int tripServiceScheduleID;

  const AddTripService(
      {this.tripServiceID = 0, this.tripServiceScheduleID = 0});

  @override
  List<Object> get props => [tripServiceID, tripServiceScheduleID];
}

class AddNewService extends TripServiceEvent {
  final int serviceID;
  final int scheduleID;
  final int tripOverflyID;
  final bool isOverFlight;

  const AddNewService(
      {required this.serviceID,
      required this.scheduleID,
      required this.tripOverflyID,
      required this.isOverFlight});

  @override
  List<Object> get props =>
      [serviceID, scheduleID, tripOverflyID, isOverFlight];
}

class AddServices extends TripServiceEvent {
  final List<TripService> tripServices;

  const AddServices({this.tripServices = const []});

  @override
  List<Object> get props => [tripServices];
}

class AddServicesToSchedule extends TripServiceEvent {
  final int scheduleID;
  final List<TripService> tripServices;

  const AddServicesToSchedule(
      {required this.scheduleID, this.tripServices = const []});

  @override
  List<Object> get props => [tripServices];
}

class SaveService extends TripServiceEvent {
  final String guid;
  final int flightCategoryId;
  final List<TripServiceSchedulePayload> tripServiceSchedulePayload;

  const SaveService(
      {required this.guid,
      required this.flightCategoryId,
      required this.tripServiceSchedulePayload});

  @override
  List<Object> get props =>
      [guid, flightCategoryId, tripServiceSchedulePayload];
}

enum AddToPayloadMode { add, update, delete }

class AddToPayload extends TripServiceEvent {
  final AddToPayloadMode addToPayloadMode;
  final TripServiceSchedule tripSchedule;
  final TripService tripService;
  final int? tripOverflyId;

  const AddToPayload({
    required this.addToPayloadMode,
    required this.tripSchedule,
    required this.tripService,
    this.tripOverflyId,
  });

  @override
  List<Object> get props => [addToPayloadMode, tripSchedule, tripService];
}

class FetchFlightRequirement extends TripServiceEvent {
  final TripServiceModalType type;
  final int airportID;
  final int countryID;

  const FetchFlightRequirement(
      {this.type = TripServiceModalType.LOCATION,
      this.airportID = 0,
      this.countryID = 0});

  @override
  List<Object> get props => [type, airportID, countryID];
}

class FetchAirportRequirement extends TripServiceEvent {
  final int airportID;

  const FetchAirportRequirement({this.airportID = 0});

  @override
  List<Object> get props => [airportID];
}

class EditServices extends TripServiceEvent {}

class DiscardChanges extends TripServiceEvent {}

class SearchServices extends TripServiceEvent {
  final String searchText;

  const SearchServices(this.searchText);

  @override
  List<Object> get props => [searchText];
}
