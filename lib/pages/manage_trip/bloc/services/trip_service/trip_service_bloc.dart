import 'dart:math';

import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_event.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_state.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripServiceBloc extends Bloc<TripServiceEvent, TripServiceState> {
  static const List<String> servicesInOverFlight = [
    'Notification (OVF)',
    'Permit (OVF)',
    'Diplomatic (OVF)',
    'Block (OVF)'
  ];
  static const String newService = 'Not Actioned',
      inProgress = 'Needs Follow-up',
      cancelled = 'Cancelled',
      confirmed = 'Confirmed';
  static const String serviceStatusNew = 'NEW',
      serviceStatusInprogress = 'INPROGRESS',
      serviceStatusConfirmed = 'CONFIRMED';
  static const String original = 'Original';
  static const List<String> payment = ['Credit', 'Customer'];
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  final TripManagerServiceRepository _tripManagerServiceRepository;
  TripServiceMain? _tripServiceMain;
  TripServiceMain? _tripServiceMainEdited;
  bool editMode = false;
  String searchText = '';

  //Payload
  static List<TripServiceSchedulePayload> payload = [];

  TripServiceBloc(
      {required TripManagerServiceRepository tripManagerServiceRepository})
      : _tripManagerServiceRepository = tripManagerServiceRepository,
        super(const TripServiceState()) {
    on<FetchTripService>(_getTripService);
    on<DeleteTripService>(_deleteTripService);
    on<AddNewService>(_addNewService);
    on<AddServices>(_addServices);
    on<AddServicesToSchedule>(_addServicesToSchedule);
    on<AddToPayload>(_addToPayload);
    on<EditServices>(_editServices);
    on<DiscardChanges>(_discardChanges);
    on<SearchServices>(_searchServices);
  }

  void _editServices(
    TripServiceEvent event,
    Emitter<TripServiceState> emit,
  ) {
    try {
      _tripServiceMainEdited =
          TripServiceMain.fromJson(_tripServiceMain!.toJson());
      editMode = true;
    } catch (e) {
      print(e);
    }
  }

  void _discardChanges(
    TripServiceEvent event,
    Emitter<TripServiceState> emit,
  ) {
    _tripServiceMainEdited =
        TripServiceMain.fromJson(_tripServiceMain!.toJson());
    editMode = false;
    emit(state.copyWith(
      status: FetchTripServiceStatus.success,
      tripServiceMain: _tripServiceMainEdited ?? const TripServiceMain(),
    ));
  }

  TripServiceMain? getTripServiceMainObject(TripServiceMain? processedObject) {
    if (searchText.isEmpty) {
      return processedObject;
    }
    TripServiceMain? tripServiceData =
        editMode ? _tripServiceMainEdited : _tripServiceMain;
    return tripServiceData!.copyWith(
      services: tripServiceData.services!
          .where((element) => (element.service ?? '')
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList(),
      mondatoryServices: tripServiceData.mondatoryServices,
      schedule: tripServiceData.schedule,
      objectEqualityChecker: getRandomString(16),
    );
  }

  void _searchServices(
    TripServiceEvent event,
    Emitter<TripServiceState> emit,
  ) {
    try {
      SearchServices searchServices = event as SearchServices;
      searchText = searchServices.searchText;
      if (searchServices.searchText.isEmpty) {
        emit(state.copyWith(
          status: FetchTripServiceStatus.success,
          tripServiceMain: editMode
              ? _tripServiceMainEdited ?? const TripServiceMain()
              : _tripServiceMain ?? const TripServiceMain(),
        ));
        return;
      }
      TripServiceMain? tripServiceData =
          editMode ? _tripServiceMainEdited : _tripServiceMain;
      tripServiceData = tripServiceData!.copyWith(
        services: tripServiceData.services!
            .where((element) => (element.service ?? '')
                .toLowerCase()
                .contains(searchServices.searchText.toLowerCase()))
            .toList(),
        mondatoryServices: tripServiceData.mondatoryServices,
        schedule: tripServiceData.schedule,
        objectEqualityChecker: getRandomString(16),
      );
      emit(state.copyWith(
        status: FetchTripServiceStatus.success,
        tripServiceMain: tripServiceData,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FetchTripServiceStatus.success,
        tripServiceMain: editMode
            ? _tripServiceMainEdited ?? const TripServiceMain()
            : _tripServiceMain ?? const TripServiceMain(),
      ));
    }
  }

  Future<void> _getTripService(
    TripServiceEvent event,
    Emitter<TripServiceState> emit,
  ) async {
    payload.clear();
    FetchTripService fetchTripService = event as FetchTripService;
    if (fetchTripService.guid.isEmpty) {
      return;
    }
    emit(state.copyWith(
        status: FetchTripServiceStatus.loading,
        tripServiceMain: const TripServiceMain()));
    try {
      _tripServiceMain = await _tripManagerServiceRepository
          .getTripServiceDetails(guid: fetchTripService.guid);
      _tripServiceMainEdited = _tripServiceMain;
      emit(state.copyWith(
        status: FetchTripServiceStatus.success,
        tripServiceMain: _getNewCopy(),
      ));
    } catch (e) {
      emit(state.copyWith(
          status: FetchTripServiceStatus.failure,
          tripServiceMain: _tripServiceMain ?? const TripServiceMain()));
    }
  }

  void _deleteTripService(
    TripServiceEvent event,
    Emitter<TripServiceState> emit,
  ) {
    emit(state.copyWith(
      status: FetchTripServiceStatus.idle,
      tripServiceMain: _tripServiceMainEdited ?? const TripServiceMain(),
    ));
    DeleteTripService deleteService = event as DeleteTripService;
    if (deleteService.tripServiceID == 0 ||
        deleteService.tripServiceScheduleID == 0) {
      return;
    }
    if (deleteService.isOverFlight && deleteService.tripOverflyID == 0) {
      return;
    }
    if (_tripServiceMainEdited == null) {
      return;
    }
    if (_tripServiceMainEdited!.schedule == null) {
      return;
    }
    try {
      print(deleteService);
      print("Trip service- id ${deleteService.tripServiceID}");
      print("Trip schedule- id ${deleteService.tripServiceScheduleID}");
      print("Trip overfly- id ${deleteService.tripOverflyID}");
      print("isOverFlight- ${deleteService.isOverFlight}");
      TripServiceSchedule? deletingItemFromSchedule = _tripServiceMainEdited!
          .schedule!
          .where((element) =>
              element.tripScheduleId == deleteService.tripServiceScheduleID)
          .toList()
          .first;
      if (deleteService.isOverFlight) {
        deletingItemFromSchedule = null;
        deletingItemFromSchedule = _tripServiceMainEdited!.schedule!
            .where((element) =>
                element.tripScheduleId == deleteService.tripServiceScheduleID &&
                element.tripOverflyId == deleteService.tripOverflyID)
            .toList()
            .first;
      }

      deletingItemFromSchedule.services!.removeWhere(
          (element) => element.serviceId == deleteService.tripServiceID);

      TripServiceMain newCopy = _getNewCopy();
      _tripServiceMainEdited = newCopy;
      emit(
        state.copyWith(
          status: FetchTripServiceStatus.success,
          tripServiceMain:
              getTripServiceMainObject(newCopy) ?? const TripServiceMain(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FetchTripServiceStatus.failure,
          tripServiceMain: _tripServiceMainEdited ?? const TripServiceMain(),
        ),
      );
    }
  }

  TripServiceMain _getNewCopy() {
    return TripServiceMain(
      objectEqualityChecker: getRandomString(16),
      services: _tripServiceMainEdited!.services!
          .map(
            (e) => TripService(
              scheduleStatus: e.scheduleStatus,
              service: e.service,
              serviceCode: e.serviceCode,
              serviceId: e.serviceId,
              serviceStatus: e.serviceStatus,
              status: e.status,
              through: e.through,
              tripServiceId: e.tripServiceId,
              vendorId: e.vendorId,
              tripOverflyServiceId: e.tripOverflyServiceId,
            ),
          )
          .toList(),
      schedule: _tripServiceMainEdited!.schedule!
          .map(
            (e) => TripServiceSchedule(
              services: () {
                List<TripService> services = [];
                for (TripService e in e.services!) {
                  TripService service = TripService(
                    scheduleStatus: e.scheduleStatus,
                    service: e.service,
                    serviceCode: e.serviceCode,
                    serviceId: e.serviceId,
                    serviceStatus: e.serviceStatus,
                    status: e.status,
                    through: e.through,
                    tripServiceId: e.tripServiceId,
                    vendorId: e.vendorId,
                    isRemovable: e.isRemovable,
                    tripOverflyServiceId: e.tripOverflyServiceId,
                  );
                  services.add(service);
                }
                return services;
              }(),
              airportId: e.airportId,
              isOverFlight: e.isOverFlight,
              timezone: e.timezone,
              eTA: e.eTA,
              eTATBA: e.eTATBA,
              eTD: e.eTD,
              eTDTBA: e.eTDTBA,
              flightCategoryId: e.flightCategoryId,
              mandatoryServicesList: e.mandatoryServicesList,
              name: e.name,
              tripScheduleId: e.tripScheduleId,
              tripOverflyId: e.tripOverflyId,
            ),
          )
          .toList(),
      mondatoryServices: _tripServiceMainEdited!.mondatoryServices,
    );
  }

  void _addNewService(
    TripServiceEvent event,
    Emitter<TripServiceState> emit,
  ) {
    AddNewService addNewService = event as AddNewService;
    if (addNewService.serviceID == 0 || addNewService.scheduleID == 0) {
      return;
    }
    if (addNewService.isOverFlight && addNewService.tripOverflyID == 0) {
      return;
    }
    if (_tripServiceMainEdited == null) {
      return;
    }
    if (_tripServiceMainEdited!.schedule == null) {
      return;
    }
    try {
      TripService service = _tripServiceMainEdited!.services!
          .where((element) => element.serviceId == addNewService.serviceID)
          .first;
      TripService newService = TripService(
        tripServiceId: 0,
        serviceId: service.serviceId,
        serviceStatus: 'Not Actioned',
        status: service.status,
        isRemovable: true,
        through: service.through,
        scheduleStatus: service.scheduleStatus,
        service: service.service,
        vendorId: service.vendorId,
        serviceCode: service.serviceCode,
        tripOverflyServiceId: service.tripOverflyServiceId,
      );
      List<TripServiceSchedule> temp = _tripServiceMainEdited!.schedule!
          .where(
              (element) => element.tripScheduleId == addNewService.scheduleID)
          .toList();
      if (temp.length > 1) {
        temp
            .where((element) {
              print(element);
              if (addNewService.isOverFlight) {
                return element.tripOverflyId == addNewService.tripOverflyID;
              } else {
                return element.isOverFlight == addNewService.isOverFlight;
              }
            })
            .first
            .services!
            .add(newService);
      } else {
        _tripServiceMainEdited!.schedule!
            .where(
                (element) => element.tripScheduleId == addNewService.scheduleID)
            .first
            .services!
            .add(newService);
      }
      TripServiceMain tripService = TripServiceMain(
        objectEqualityChecker: getRandomString(16),
        services: _tripServiceMainEdited!.services,
        schedule: _tripServiceMainEdited!.schedule,
        mondatoryServices: _tripServiceMainEdited!.mondatoryServices,
      );
      _tripServiceMainEdited = tripService;
      emit(state.copyWith(
          status: FetchTripServiceStatus.success,
          tripServiceMain: getTripServiceMainObject(tripService) ??
              const TripServiceMain()));
    } catch (e) {
      emit(
        state.copyWith(
          status: FetchTripServiceStatus.failure,
          tripServiceMain: _tripServiceMainEdited ?? const TripServiceMain(),
        ),
      );
    }
  }

  void _addServices(
    TripServiceEvent event,
    Emitter<TripServiceState> emit,
  ) {
    AddServices addServices = event as AddServices;
    if (_tripServiceMainEdited == null) {
      return;
    }
    if (_tripServiceMainEdited!.services == null) {
      return;
    }
    TripServiceMain newTripDetails = _tripServiceMainEdited!.copyWith(
      services: addServices.tripServices,
      objectEqualityChecker: getRandomString(16),
      schedule: _tripServiceMainEdited?.schedule,
      mondatoryServices: _tripServiceMainEdited?.mondatoryServices,
    );
    _tripServiceMainEdited = newTripDetails;
    emit(state.copyWith(
        status: FetchTripServiceStatus.success,
        tripServiceMain: newTripDetails));
  }

  void _addServicesToSchedule(
    TripServiceEvent event,
    Emitter<TripServiceState> emit,
  ) {
    try {
      AddServicesToSchedule addServicesToSchedule =
          event as AddServicesToSchedule;
      if (_tripServiceMainEdited == null) {
        return;
      }
      if (_tripServiceMainEdited!.services == null) {
        return;
      }
      if (addServicesToSchedule.scheduleID == 0) {
        return;
      }
      TripServiceMain newTripDetails = _tripServiceMainEdited!.copyWith(
        services: _tripServiceMainEdited?.services,
        objectEqualityChecker: getRandomString(16),
        schedule: _tripServiceMainEdited?.schedule!.map((e) {
          if (addServicesToSchedule.scheduleID == e.tripScheduleId) {
            return TripServiceSchedule(
              isOverFlight: e.isOverFlight,
              timezone: e.timezone,
              services: addServicesToSchedule.tripServices,
              tripScheduleId: e.tripScheduleId,
              name: e.name,
              mandatoryServicesList: e.mandatoryServicesList,
              flightCategoryId: e.flightCategoryId,
              eTDTBA: e.eTDTBA,
              eTD: e.eTD,
              eTATBA: e.eTATBA,
              eTA: e.eTA,
              airportId: e.airportId,
            );
          }
          return TripServiceSchedule(
            isOverFlight: e.isOverFlight,
            timezone: e.timezone,
            services: e.services,
            tripScheduleId: e.tripScheduleId,
            name: e.name,
            mandatoryServicesList: e.mandatoryServicesList,
            flightCategoryId: e.flightCategoryId,
            eTDTBA: e.eTDTBA,
            eTD: e.eTD,
            eTATBA: e.eTATBA,
            eTA: e.eTA,
            airportId: e.airportId,
          );
        }).toList(),
        mondatoryServices: _tripServiceMainEdited?.mondatoryServices,
      );
      _tripServiceMainEdited = newTripDetails;
      emit(state.copyWith(
          status: FetchTripServiceStatus.success,
          tripServiceMain: newTripDetails));
    } catch (e) {
      print(e);
    }
  }

  void _addToPayload(
    TripServiceEvent event,
    Emitter<TripServiceState> emit,
  ) {
    try {
      emit(state.copyWith(
        status: FetchTripServiceStatus.idle,
        tripServiceMain: _tripServiceMainEdited ?? const TripServiceMain(),
      ));
      AddToPayload addToPayload = event as AddToPayload;
      int index = payload.indexWhere(
        (element) =>
            element.tripScheduleId == addToPayload.tripSchedule.tripScheduleId,
      );
      Map<String, dynamic> _payload = _getTripServiceSchedulePayload(
        addToPayloadMode: addToPayload.addToPayloadMode,
        tripServiceSchedule: addToPayload.tripSchedule,
        tripService: addToPayload.tripService,
        tripOverflyId: addToPayload.tripOverflyId,
      );
      if (index == -1) {
        payload.add(
          TripServiceSchedulePayload(
            tripScheduleId: addToPayload.tripSchedule.tripScheduleId,
            tripServices: [_payload],
          ),
        );
      } else {
        if (payload[index].tripServices == null) {
          payload[index].tripServices = [_payload];
        } else {
          int selectedServiceIndex = 0;
          List<Map<String, dynamic>>? _tripServices =
              payload[index].tripServices;
          if (_tripServices != null && _tripServices.isNotEmpty) {
            //MARK:- This is to check if already exists in payload, if adding service then delete the service from payload and if deleting service then vice versa
            if (addToPayload.addToPayloadMode == AddToPayloadMode.add) {
              _tripServices.removeWhere((element) {
                return element['action'] == 'DELETE' &&
                    element['serviceName'] == addToPayload.tripService.service;
              });
            } else if (addToPayload.addToPayloadMode ==
                AddToPayloadMode.delete) {
              _tripServices.removeWhere((element) {
                return element['action'] == 'ADD' &&
                    element['serviceName'] == addToPayload.tripService.service;
              });
            }

            //MARK:- This is the place where the service is getting added to payload
            selectedServiceIndex = _tripServices.indexWhere((element) {
              if (addToPayload.tripOverflyId != null) {
                return element['tripScheduleId'] ==
                        addToPayload.tripSchedule.tripScheduleId &&
                    element['tripOverflyId'] == addToPayload.tripOverflyId;
              } else {
                return element['tripScheduleId'] ==
                        addToPayload.tripSchedule.tripScheduleId &&
                    element['serviceId'] ==
                        addToPayload.tripService.serviceId &&
                    element['tripOverflyId'] == null;
              }
            });
          }

          if (selectedServiceIndex == -1) {
            _tripServices!.add(_payload);
          }
        }
      }
      TripServiceMain newCopy = _getNewCopy();
      _tripServiceMainEdited = newCopy;
      emit(
        state.copyWith(
          status: FetchTripServiceStatus.success,
          tripServiceMain:
              getTripServiceMainObject(newCopy) ?? const TripServiceMain(),
        ),
      );
      print("added the services ${addToPayload.tripOverflyId}");
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> _getTripServiceSchedulePayload({
    required AddToPayloadMode addToPayloadMode,
    required TripServiceSchedule tripServiceSchedule,
    required TripService tripService,
    int? tripOverflyId,
  }) {
    Map<String, dynamic> servicePayload = <String, dynamic>{};
    servicePayload['serviceName'] = tripService.service;
    servicePayload['action'] =
        _getAddToPayloadMode(addToPayloadMode: addToPayloadMode);
    servicePayload['serviceId'] =
        tripService.serviceId == 0 ? null : tripService.serviceId;
    servicePayload['tripOverflyId'] = tripOverflyId;
    servicePayload['name'] = tripServiceSchedule.name;
    servicePayload['mandatory'] = _isMandatoryService(tripService: tripService);
    servicePayload['through'] = 'Direct';
    servicePayload['tripScheduleId'] = tripServiceSchedule.tripScheduleId;
    servicePayload['isDefault'] = false;
    return servicePayload;
  }

  String _getAddToPayloadMode({required AddToPayloadMode addToPayloadMode}) {
    switch (addToPayloadMode) {
      case AddToPayloadMode.add:
        return 'ADD';
      case AddToPayloadMode.delete:
        return 'DELETE';
      case AddToPayloadMode.update:
        return 'UPDATE';
    }
  }

  bool _isMandatoryService({required TripService tripService}) {
    try {
      return _tripServiceMainEdited!.mondatoryServices!
          .where((element) => element.serviceId == tripService.serviceId)
          .isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  static canAddServiceToSchedule(
      {required TripServiceSchedule tripSchedule,
      required String serviceName}) {
    if (servicesInOverFlight.contains(serviceName)) {
      return tripSchedule.isOverFlight ?? false;
    }

    if (tripSchedule.isOverFlight ?? false) {
      return servicesInOverFlight.contains(serviceName);
    }

    //A Flight Support category service with (T/O) in brackets
    // can ONLY be applied to an AIRPORT column with a DEPARTURE schedule (ONLY)
    if (serviceName.contains('(T/O)')) {
      return tripSchedule.eTD != null && tripSchedule.eTA == null;
    } else
    // A Flight Support category service with (LDG&T/O) in brackets
    // can ONLY be applied to an AIRPORT column with an ARRIVAL & DEPARTURE schedule
    if (serviceName.contains('(LDG&T/O)')) {
      return tripSchedule.eTD != null && tripSchedule.eTA != null;
    } else
    // A Flight Support category service with (LDG) in brackets
    // can ONLY be applied to an AIRPORT column with an ARRIVAL schedule (ONLY)
    if (serviceName.contains('(LDG)')) {
      return tripSchedule.eTD == null && tripSchedule.eTA != null;
    } else {
      return true;
    }
  }
}
