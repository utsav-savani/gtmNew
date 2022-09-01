import 'package:airport_repository/airport_repository.dart';
import 'package:flight_category_repository/flight_category_repository.dart';
import 'package:flight_purpose_repository/flight_purpose_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trip_manager_repository/trip_manager_repository.dart';
import 'package:timezone/browser.dart' as tz;

class TripManagerScheduleRepository {
  late List<Trip> tripList;
  List<TripSchedule> _scheduleData = <TripSchedule>[];

  List<TripSchedulePrePayload> _schedulePayload = <TripSchedulePrePayload>[];

  List<TripSchedulePrePayload> get schedulePayload => _schedulePayload;
  List<int> _deletedScheduleId = <int>[];
  List<int> _deletedOverflyId = <int>[];

  //MARK:- This is to return the trip manager dashboard statistics
  Future<List<TripSchedule>> getTripScheduleData({
    required String guid,
  }) async {
    try {
      final url = Uri.parse(TripManagerUrls().getTripScheduleData(guid: guid));

      final headers = await UserRepository().getHeaders();
      print("URL: $url \n Token: ${json.encode(headers)}");

      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final responseData = jsonResponse['data'] as List<dynamic>;
          for (var item in responseData) {
            _scheduleData.add(TripSchedule.fromJson(item));
          }
          return _scheduleData;
        } else {
          ///print(response.body);
        }
      });
    } catch (e) {
      print(e);
    }
    return _scheduleData;
  }

  //MARK:- This is to return the trip manager dashboard statistics
  Future<List<TripSchedule>> getCancelledTripSchedule({
    required int tripId,
  }) async {
    List<TripSchedule> _scheduleData = [];
    try {
      final url = Uri.parse(
          TripManagerUrls().getTripCancelScheduleData(tripId: tripId));

      final headers = await UserRepository().getHeaders();
      print("URL: $url \n Token: ${json.encode(headers)}");

      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final responseData = jsonResponse as List<dynamic>;
          for (var item in responseData) {
            _scheduleData.add(TripSchedule.fromJson(item));
          }
        } else {
          ///print(response.body);
        }
      });
    } catch (e) {
      ///print(e);
    }
    return _scheduleData;
  }

  //MARK:- This is to get the trip schedule details and generate the trip schedule payload
  Future<void> reset() async {
    _scheduleData = [];
    _schedulePayload = [];
  }

  //MARK:- This is to get the trip schedule details and generate the trip schedule payload
  Future<List<TripSchedulePrePayload>> getAndGenerateTripSchedulePayload({
    required String guid,
  }) async {
    _scheduleData = await getTripScheduleData(guid: guid);
    print("==========");
    print(_scheduleData);
    print("==========");
    _deletedOverflyId = [];
    _deletedScheduleId = [];
    _schedulePayload =
        await generateTripSchedulePayload(schedules: _scheduleData);
    return _schedulePayload;
  }

  //MARK:- This is to generate the trip schedule payload
  Future<List<TripSchedulePrePayload>> generateTripSchedulePayload({
    required List<TripSchedule> schedules,
  }) async {
    try {
      _schedulePayload = <TripSchedulePrePayload>[];

      if (schedules.length == 0) {
        addSchedule(index: 0, isBefore: false);
      }

      ///print("======Ready to generate payload======");
      for (TripSchedule tripSchedule in schedules) {
        TripSchedulePrePayload _prePayload = TripSchedulePrePayload();
        _prePayload.setTripScheduleId(tripSchedule.tripScheduleId);
        _prePayload.setCategoryId(tripSchedule.flightCategoryId);
        _prePayload.setCategory(tripSchedule.tripScheduleFlightCategory);
        _prePayload.setETA(tripSchedule.eTA);
        _prePayload.setUTC(true);
        _prePayload.setETG(tripSchedule.eTG);
        _prePayload.setETE(tripSchedule.eTE);
        _prePayload.setPurposeId(tripSchedule.flightPurposeId);
        _prePayload.setPurpose(tripSchedule.tripFlightPurpuses);
        _prePayload.setCallsign(tripSchedule.callSign);
        _prePayload.setATCRTE(tripSchedule.aTCRoute);
        _prePayload.setDepartureArrival(tripSchedule.arivaldeparturetype);
        _prePayload.setAirportId(tripSchedule.airportId);
        _prePayload.setAirport(tripSchedule.tripAirports);
        _prePayload.setSplit(tripSchedule.split);
        _prePayload.setSplitPrevious(tripSchedule.previousSplit);
        _prePayload.setIsETATBA(tripSchedule.eTATBA);
        _prePayload.setIsETDTBA(tripSchedule.eTDTBA);
        _prePayload.setETAStatus(tripSchedule.eTAStatus);
        _prePayload.setETDStatus(tripSchedule.eTDStatus);

        //MARK:- This it to set ETA
        bool _isETD = tripSchedule.isETD ?? false;
        if (!_isETD && (tripSchedule.isETD != null || tripSchedule.isETD != ""))
          _isETD = true;
        _prePayload.setIsETD(_isETD);
        _prePayload.setIsETA(tripSchedule.isETA);

        _prePayload.setETD(tripSchedule.eTD);
        _prePayload.setATDTime(tripSchedule.aTDTime);

        _prePayload.setETA(tripSchedule.eTA);
        _prePayload.setATATime(tripSchedule.aTATime);

        List<TripSchedulePreOverflightPayload> _overflights = [];
        if (tripSchedule.tripScheduleOverflyCountry != null) {
          _overflights =
              getOverflightPrePayload(tripSchedule.tripScheduleOverflyCountry!);
        }
        _prePayload.setOverflights(_overflights);
        _schedulePayload.add(_prePayload);
      }
      print(_schedulePayload.length.toString());
      print(_schedulePayload[0].overflights().length.toString());
      print(_schedulePayload[0].flightCategoryId().toString());
      print("======generated payload======");
    } catch (e) {
      print(e);
    }
    return _schedulePayload;
  }

  List<TripSchedulePreOverflightPayload> getOverflightPrePayload(
      List<TripScheduleOverflight> overflights) {
    List<TripSchedulePreOverflightPayload> _res = [];
    for (TripScheduleOverflight overflight in overflights) {
      TripSchedulePreOverflightPayload _payload =
          TripSchedulePreOverflightPayload();
      _payload.setOverflightId(overflight.tripOverflyId);
      _payload.setCountryName(overflight.overflyCountry);
      _payload.setEntryPoint(overflight.entryPoint);
      _payload.setExitPoint(overflight.exitPoint);
      _payload.setCode(overflight.code);
      _payload.setSequenceNum(overflight.sequenceNum);
      _res.add(_payload);
    }
    return _res;
  }

  //MARK:- Set TripScheduel Payload
  //MARK:- Set TripSchedule Airport Id
  void setAirportId({required int index, required int airportId}) =>
      _schedulePayload[index].setAirportId(airportId);
  //MARK:- Set TripSchedule Airport
  void setAirport({required int index, required Airport airport}) =>
      _schedulePayload[index].setAirport(airport);
  //MARK:- Set TripSchedule Flight Category Id
  void setFlightCategoryId({
    required int index,
    required FlightCategory flightCategory,
    required int categoryId,
  }) {
    if (index == 0) {
      for (var schedulePayload in _schedulePayload) {
        schedulePayload.setCategory(flightCategory);
        schedulePayload.setCategoryId(categoryId);
      }
    } else {
      _schedulePayload[index].setCategory(flightCategory);
      _schedulePayload[index].setCategoryId(categoryId);
    }
  }

  //MARK:- Set Purpose Id
  void setPurposeId({
    required int index,
    required FlightPurpose flightPurpose,
    required int purposeId,
  }) {
    if (index == 0) {
      for (var schedulePayload in _schedulePayload) {
        schedulePayload.setPurpose(flightPurpose);
        schedulePayload.setPurposeId(purposeId);
      }
    } else {
      _schedulePayload[index].setPurpose(flightPurpose);
      _schedulePayload[index].setPurposeId(purposeId);
    }
  }

  void setCallsign({required int index, required String callsign}) {
    if (index == 0) {
      for (var schedulePayload in _schedulePayload) {
        schedulePayload.setCallsign(callsign);
      }
    } else {
      _schedulePayload[index].setCallsign(callsign);
    }
  }

  //MARK: Get previous date
  Future<DateTime?> getInitialDateForETD({required int index}) async {
    //MARK:- if the etd value is not null then return
    String? etd = _schedulePayload[index].etd();
    if (etd != null) return DateTime.parse(etd);

    //MARK:- check previous ETA and add one hour
    int indexNew = index - 1;
    if (_schedulePayload.length > 1 && indexNew >= 0) {
      String? eta = _schedulePayload[indexNew].eta();
      if (eta != null) return DateTime.parse(eta).add(Duration(hours: 1));
    }
    return null;
  }

  //MARK: Get previous date
  Future<DateTime?> getInitialDateForETA({required int index}) async {
    TripSchedulePrePayload _currentIndex = _schedulePayload[index];
    //MARK:- if the etd value is not null then return
    String? eta = _currentIndex.eta();
    if (eta != null) return DateTime.parse(eta);

    if (_currentIndex.etd() != null) {
      String? etd = _currentIndex.etd();
      if (etd != null) return DateTime.parse(etd).add(Duration(hours: 1));
    } else {
      String? etd = _schedulePayload[index - 1].etd();
      if (etd != null) return DateTime.parse(etd).add(Duration(hours: 1));
    }
    return null;
  }

  //MARK:- Set TripSchedule ETA
  void setETA({required int index, required String eta}) {
    TripSchedulePrePayload _selectedIndexArrival = _schedulePayload[index];
    TripSchedulePrePayload _selectedIndexDeparture =
        _schedulePayload[index - 1];

    TripSchedulePrePayload? _selectedIndexNextDeparture;
    if (_schedulePayload.length > 1 &&
        _schedulePayload.length < index &&
        _selectedIndexArrival.etd() != null) {
      _selectedIndexNextDeparture = _schedulePayload[index + 1];
    }

    String? _etaa = _selectedIndexArrival.eta();
    if (_etaa != null && _selectedIndexArrival.aTATime() != null) {
      _selectedIndexArrival.setATATime(eta);
      _etaa = _selectedIndexArrival.aTATime();
    } else {
      _etaa = eta;
      _selectedIndexArrival.setETA(eta);
    }

    String _etdd = _selectedIndexDeparture.etd();
    if (_selectedIndexDeparture.aTDTime() != null)
      _etdd = _selectedIndexDeparture.aTDTime();
    _updateETE(
      selectedIndex: _selectedIndexDeparture,
      eta: _etaa!,
      etd: _etdd,
    );

    if (_selectedIndexNextDeparture == null) {
      _selectedIndexArrival.setETG(null);
    } else {
      String? _etdd = _selectedIndexArrival.etd();
      if (_selectedIndexDeparture.aTDTime() != null)
        _etdd = _selectedIndexDeparture.aTDTime();
      String? _etaa = _selectedIndexArrival.eta();
      if (_selectedIndexArrival.aTATime() != null)
        _etaa = _selectedIndexArrival.aTATime();
      if (_etdd != null && _etaa != null)
        _updateEGT(
          egtTripPayload: _selectedIndexArrival,
          eta: _etaa,
          etd: _etdd,
        );

      String? _etdNext = _selectedIndexNextDeparture.etd();
      if (_selectedIndexNextDeparture.aTDTime() != null)
        _etdNext = _selectedIndexNextDeparture.aTDTime();
      if (_etdNext != null && _etaa != null)
        _updateEGT(
          egtTripPayload: _selectedIndexArrival,
          eta: _etaa,
          etd: _etdNext,
        );
    }
  }

  void setETD({required int index, required String etd}) {
    TripSchedulePrePayload _selectedIndex = _schedulePayload[index];
    TripSchedulePrePayload? _selectedIndexArrival;
    if (_schedulePayload.length > 1) {
      _selectedIndexArrival = _schedulePayload[index + 1];
    }
    String? _etdd = _selectedIndex.etd();
    if (_etdd != null && _selectedIndex.aTDTime() != null) {
      _selectedIndex.setATDTime(etd);
      _etdd = _selectedIndex.aTDTime();
    } else {
      _etdd = etd;
      _selectedIndex.setETD(etd);
    }

    if (_selectedIndexArrival != null) {
      String? _arrivalTime = _selectedIndexArrival.eta();
      if (_selectedIndexArrival.aTATime() != null)
        _arrivalTime = _selectedIndexArrival.aTATime();
      if (_etdd != null && _arrivalTime != null) {
        _updateETE(
          selectedIndex: _selectedIndex,
          eta: _arrivalTime,
          etd: _etdd,
        );
      }

      //MARK: This is to check only departure or both
      if (_selectedIndex.eta() != null && _selectedIndex.etd() != null) {
        _updateEGT(
          egtTripPayload: _selectedIndex,
          eta: _selectedIndex.eta(),
          etd: _etdd,
        );
      }
    }
  }

  _updateEGT({
    required TripSchedulePrePayload egtTripPayload,
    required String eta,
    String? etd,
  }) {
    if (etd == null) return;

    DateTime etaDateTime = DateTime.parse(eta);
    DateTime etdDateTime = DateTime.parse(etd);

    int inHours = etaDateTime.difference(etdDateTime).inHours.abs();
    int inMinutes = etaDateTime.difference(etdDateTime).inMinutes.abs();
    inMinutes = inMinutes % 60;

    egtTripPayload.setETG(null);
    String inMinutesStr = "${inMinutes}".padLeft(2, '0');
    String inHoursStr = "${inHours}".padLeft(4, '0');
    String _egt = "$inHoursStr:$inMinutesStr";
    egtTripPayload.setETG(_egt);
  }

  _updateETE({
    required TripSchedulePrePayload selectedIndex,
    required String eta,
    required String etd,
  }) {
    DateTime etaDateTime = DateTime.parse(eta);
    DateTime etdDateTime = DateTime.parse(etd);

    int inDays = etaDateTime.difference(etdDateTime).inDays.abs();
    int inHours = etaDateTime.difference(etdDateTime).inHours.abs();
    int inMinutes = etaDateTime.difference(etdDateTime).inMinutes.abs();
    inMinutes = inMinutes % 60;

    selectedIndex.setETE(null);
    if (inDays < 1) {
      String inMinutesStr = "${inMinutes}".padLeft(2, '0');
      String inHoursStr = "${inHours}".padLeft(2, '0');
      String _ete = "$inHoursStr:$inMinutesStr";
      selectedIndex.setETE(_ete);
    }
  }

  //MARK:- Set TripSchedule ETE
  void setETE({required int index, required String ete}) {
    TripSchedulePrePayload _etePayload = _schedulePayload[index];

    if (ete.length < 5) return;

    int minutes = 0;
    int hours = 0;
    String etdTime = _etePayload.etd();
    if (etdTime.isEmpty) return;
    final splittedValue = ete.toString().split(":");
    hours = int.parse(splittedValue[0]);
    if (splittedValue.length > 1) minutes = int.parse(splittedValue[1]);
    if (hours <= 23 && minutes <= 59) {
      DateTime etaDateTime = DateTime.parse(etdTime);
      etaDateTime = etaDateTime.add(Duration(hours: hours, minutes: minutes));
      _etePayload.setETE(ete);

      if (_schedulePayload.length > 1) {
        TripSchedulePrePayload _etaPayload = _schedulePayload[index + 1];
        _etaPayload.setETA(etaDateTime.toString());
      }
    }
  }

  //MARK:- Set TripSchedule ETG
  void setETG({required int index, required String etg}) {
    TripSchedulePrePayload _selectedIndex = _schedulePayload[index];

    if (etg.length < 7) return;

    int minutes = 0;
    final splittedValue = etg.toString().split(":");
    final int hours = int.parse(splittedValue[0]);
    if (splittedValue.length > 1) minutes = int.parse(splittedValue[1]);
    if (hours <= 9999 && minutes <= 59) _selectedIndex.setETG(etg);

    DateTime _eta = DateTime.parse(_selectedIndex.eta());
    DateTime _etd = _eta.add(Duration(hours: hours, minutes: minutes));
    _selectedIndex.setETD(_etd.toString());
  }

  void setATCRTE({required int index, required String str}) =>
      _schedulePayload[index].setATCRTE(str);
  void setATCRTEDisplay({required int index, required bool value}) =>
      _schedulePayload[index].setATCRTEDisplay(value);
  //MARK:- Set ETD TBA
  void setETDTBA({required int index, required bool value}) {
    TripSchedulePrePayload _selectedIndex = _schedulePayload[index];
    _selectedIndex.setIsETDTBA(value);
    _selectedIndex.setETD(null);
    _selectedIndex.setETDLocal(null);
    _selectedIndex.setETE(null);
    _selectedIndex.setETG(null);
    TripSchedulePrePayload _selectedIndexNext = _schedulePayload[index + 1];
    _selectedIndexNext.setETA(null);
    _selectedIndexNext.setETALocal(null);
    _selectedIndexNext.setIsETATBA(value);
    _selectedIndexNext.setETE(null);
    _selectedIndexNext.setETG(null);
  }

  //MARK:- Set ETA TBA
  void setETATBA({required int index, required bool value}) {
    TripSchedulePrePayload _selectedIndex = _schedulePayload[index];
    _selectedIndex.setIsETATBA(value);
    TripSchedulePrePayload _selectedIndexPrev = _schedulePayload[index - 1];
    _selectedIndexPrev.setIsETDTBA(value);
  }

  //MARK:- This is to set ETD to ATD
  void setETDToATD({required int index}) {
    TripSchedulePrePayload _selectedIndex = _schedulePayload[index];
    if (_selectedIndex.etd() != null) {
      _selectedIndex.setIsETD(false);
      _selectedIndex.setATDTime(_selectedIndex.etd());
    }
  }

  //MARK:- This is to set ATD to ETD
  void setATDToETD({required int index}) {
    TripSchedulePrePayload _selectedIndex = _schedulePayload[index];
    _selectedIndex.setIsETD(true);
    _selectedIndex.setATDTime(null);
  }

  //MARK:- This is to set ETD to ATD
  void setETAToATA({required int index}) {
    TripSchedulePrePayload _selectedIndex = _schedulePayload[index];
    if (_selectedIndex.eta().isEmpty) return;
    _selectedIndex.setIsETA(true);
    _selectedIndex.setATATime(_selectedIndex.eta());
  }

  //MARK:- This is to set ATD to ETD
  void setATAToETA({required int index}) {
    TripSchedulePrePayload _selectedIndex = _schedulePayload[index];
    _selectedIndex.setIsETA(false);
    _selectedIndex.setATATime(null);
  }

  //MARK:- this is to add schedule which is same as add sequence
  void addSchedule({
    required int index,
    required bool isBefore,
    TripDetail? tripDetail,
  }) {
    try {
      TripSchedulePrePayload _selectedIndex = TripSchedulePrePayload();
      if (_schedulePayload.length > 0) {
        _selectedIndex = _schedulePayload[index];
      }
      TripSchedulePrePayload _prePayload = TripSchedulePrePayload();
      //MARK:- Trip schedule id should be null for new trip sequence
      // _prePayload.setTripScheduleId(_selectedIndex.tripScheduleId());
      _prePayload.setAirportId(_selectedIndex.airportId());
      _prePayload.setAirport(_selectedIndex.airport());
      _prePayload.setCategoryId(_selectedIndex.flightCategoryId());
      _prePayload.setCategory(_selectedIndex.flightCategory());
      _prePayload.setPurposeId(_selectedIndex.purposeId());
      _prePayload.setPurpose(_selectedIndex.purpose());
      _prePayload.setCallsign(_selectedIndex.callsign());

      _prePayload.setETAStatus("Draft");
      if (tripDetail != null) {
        _prePayload.setETAStatus(tripDetail.tripStatus);
      }
      if (_selectedIndex.eTAStatus() != null)
        _prePayload.setETAStatus(_selectedIndex.eTAStatus());

      _prePayload.setETDStatus("Draft");
      if (tripDetail != null) {
        _prePayload.setETDStatus(tripDetail.tripStatus);
      }
      if (_selectedIndex.eTAStatus() != null)
        _prePayload.setETDStatus(_selectedIndex.eTDStatus());

      _prePayload.setAirport(null);
      _prePayload.setAirportId(null);
      if (_selectedIndex.isETDTBA()) {
        _prePayload.setIsETATBA(true);
        _prePayload.setIsETDTBA(true);
      }

      if (_schedulePayload.isEmpty) {
        _schedulePayload.add(_prePayload);
      } else {
        if (!isBefore) index = index += 1;
        _schedulePayload.insert(index, _prePayload);
      }
    } catch (e) {
      print(e);
    }
  }

  void addTBA({
    required int index,
  }) {}

  //MARK:- this is to add/remove split from trip schedule
  void splitSchedule({
    required int index,
    required bool split,
    required TripDetail tripDetail,
  }) {
    if (split) {
      _addSplitSchedule(index: index, tripDetail: tripDetail);
    } else {
      _removeSplitSchedule(index: index);
    }
  }

  //MARK:- this is to add split from trip schedule
  void _addSplitSchedule({required int index, required TripDetail tripDetail}) {
    if (_schedulePayload.length <= 2)
      throw Exception('You cannot split the current schedules');

    if (index == 0) throw Exception('You cannot split the departure schedule');

    if (_schedulePayload.length == index)
      throw Exception('You cannot split the arrival schedule');

    TripSchedulePrePayload _selectedIndex = _schedulePayload[index];
    _selectedIndex.setSplit(true);
    _selectedIndex.setETG(null);
    _selectedIndex.setDepartureArrival(3);
    addSchedule(index: index, isBefore: false, tripDetail: tripDetail);
    TripSchedulePrePayload _selectedIndexNew = _schedulePayload[index + 1];
    _selectedIndexNew.setSplitPrevious(true);
    _selectedIndexNew.setDepartureArrival(1);
    _selectedIndexNew.setSplitPrevious(true);
  }

  //MARK:- this is to remove split from trip schedule
  void _removeSplitSchedule({required int index}) {
    TripSchedulePrePayload _selectedIndex = _schedulePayload[index];
    _selectedIndex.setSplit(false);
    _selectedIndex.setDepartureArrival(2);

    final _removeNextIndex = index + 1;
    _schedulePayload.removeAt(_removeNextIndex);
  }

  //MARK:- this is to remove schedule from trip schedule
  Future<List<TripSchedulePrePayload>> removeSchedule(
      {required int index}) async {
    TripSchedulePrePayload _selectedIndex = _schedulePayload[index];
    if (_schedulePayload.length > 2) {
      _schedulePayload.removeAt(index);
    } else if (_schedulePayload.length > 1) {
      if (_schedulePayload.length == 2 && !_selectedIndex.isDeparture())
        _schedulePayload.removeAt(index);
    }
    if (_selectedIndex.tripScheduleId() != null)
      _deletedScheduleId.add(_selectedIndex.tripScheduleId());
    return _schedulePayload;
  }

  //MARK:- this is to remove overflight from trip schedule
  void removeOverFlight({required int index, required int overflightIndex}) {
    TripSchedulePrePayload _selectedIndex = _schedulePayload[index];
    List<TripSchedulePreOverflightPayload> _overflights =
        _selectedIndex.overflights();
    TripSchedulePreOverflightPayload _selectedOverflightIndex =
        _overflights[overflightIndex];
    _overflights.removeAt(overflightIndex);

    int? _overflightId = _selectedOverflightIndex.overflightId();
    if (_overflightId != null && !_deletedOverflyId.contains(_overflightId))
      _deletedOverflyId.add(_overflightId);
  }

  //MARK:- this is to add overflight from trip schedule
  void addOverFlight({
    required int index,
    required TripSchedulePreOverflightPayload payload,
  }) {
    TripSchedulePrePayload _selectedIndex = _schedulePayload[index];
    _selectedIndex.setOverflight(payload);
    print("added to overflight");
  }

  //MARK:- this is to add overflight from trip schedule
  void updateOverFlight({
    required int index,
    required int overflightId,
    required TripSchedulePreOverflightPayload payload,
  }) {
    TripSchedulePrePayload _selectedIndex = _schedulePayload[index];
    int overflightIndex = _selectedIndex.overflights().indexWhere(
        (TripSchedulePreOverflightPayload item) =>
            item.overflightId() == overflightId);
    _selectedIndex.updateOverflight(overflightIndex, payload);
    print("updated to overflight");
  }

  void setUTC({required bool isUTC}) {
    for (TripSchedulePrePayload tripSchedulePayload in _schedulePayload) {
      tripSchedulePayload.setUTC(isUTC);
      tripSchedulePayload.setETDLocal(null);
      tripSchedulePayload.setETALocal(null);
      if (!isUTC) {
        String? timezone;
        if (tripSchedulePayload.airport() != null) {
          timezone = tripSchedulePayload.airport().timezone ?? null;
        }
        if (tripSchedulePayload.etd() != null) {
          tripSchedulePayload.setETDLocal(
            convertToLocal(
              "${tripSchedulePayload.etd()}",
              timezone: timezone,
            ).toString(),
          );
        }
        if (tripSchedulePayload.eta() != null) {
          tripSchedulePayload.setETALocal(
            convertToLocal(
              "${tripSchedulePayload.eta()}",
              timezone: timezone,
            ).toString(),
          );
        }
      }
    }
  }

  DateTime? convertToLocal(String utcTime, {String? timezone}) {
    if (utcTime.isEmpty) return null;
    if (timezone != null) {
      var qdetroit = tz.getLocation(timezone);
      var parsedDate = DateTime.parse(utcTime + 'Z');
      return tz.TZDateTime.from(parsedDate, qdetroit);
    } else {
      DateTime dateTime = DateTime.parse(utcTime);
      return dateTime.add(DateTime.parse(utcTime).timeZoneOffset);
    }
  }

  DateTime? convertToUTC(String localTime) {
    if (localTime.isEmpty) return null;
    return DateTime.parse(localTime).toUtc();
  }

  //MARK:- This is to get the updated Payload
  Future<List<TripSchedulePrePayload>> getUpdatedPayload() async {
    return _schedulePayload;
  }

//MARK:- This is to create trip
  Future<bool> saveTripSchedule({required String guid}) async {
    try {
      List<Map<String, dynamic>> _tripScheduleFinalPayload = [];
      int sequence = 0;
      for (TripSchedulePrePayload schedule in _schedulePayload) {
        var _overflights =
            generateOverflightMainPayload(schedule.overflights());
        sequence = sequence + 1;
        int arrivalDeparture = 2;
        if (sequence == 1) arrivalDeparture = 1;
        //MARK: Here you can handle all the logic for the last sequence
        if (sequence == _schedulePayload.length) {
          arrivalDeparture = 3;
          if (_schedulePayload.length > 1) {
            schedule.setETD(null);
          }
          schedule.setETG(null);
          schedule.setETDLocal(null);
        }

        // if (schedule.airportId() == null ||
        //     schedule.callsign() == null ||
        //     schedule.flightCategoryId() == null ||
        //     schedule.purposeId() == null) {
        //   return false;
        // }

        // if (arrivalDeparture == 3 && schedule.eta() == null) {
        //   return false;
        // }

        // if (arrivalDeparture == 3 && schedule.eta() == null) {
        //   return false;
        // }

        bool _isETD = false;
        if (schedule.aTDTime() != null) _isETD = true;
        bool _isETA = false;
        if (schedule.aTATime() != null) _isETD = true;

        TripSchedulePayload _scheduleActualPayload = TripSchedulePayload(
          airportId: schedule.airportId(),
          arivaldeparturetype: arrivalDeparture,
          callSign: schedule.callsign(),
          eTA: schedule.eta(),
          eTD: schedule.etd(),
          eTE: schedule.ete(),
          eTG: schedule.etg(),
          flightCategoryId: schedule.flightCategoryId(),
          flightPurposeId: schedule.purposeId(),
          overflyCountry: _overflights,
          split: schedule.split(),
          tripScheduleId: schedule.tripScheduleId(),
          tripsequenceNumber: sequence,
          eTDTBA: schedule.isETDTBA() ?? false,
          eTATBA: schedule.isETATBA() ?? false,
          previousSplit: schedule.splitPrevious(),
          isETD: _isETD,
          aTDTime: schedule.aTDTime(),
          aTATime: schedule.aTATime(),
          isRepeatSequence: false,
          eTDStatus: schedule.eTDStatus(),
          eTAStatus: schedule.eTAStatus(),
          isETDUTC: !schedule.isETDUTC(),
          isETAUTC: !schedule
              .isETDUTC(), //This is common because UTC is global for all arrival and departure
          aTCRoute: schedule.atcrte(),
          isETA: _isETA,
        );
        _tripScheduleFinalPayload.add(_scheduleActualPayload.toJson());
      }

      TripScheduleMainPayload _mainTripSchedulePayload =
          TripScheduleMainPayload(
        tripSchedule: _tripScheduleFinalPayload,
        guid: guid,
        newlyDeletedSchedule: [],
        deletedScheduleId: _deletedScheduleId,
        deletedOverflyId: _deletedOverflyId,
      );

      print("================Start Trip Schedule API call====================");
      final url = Uri.parse(TripManagerUrls().saveTripSchedule());
      final headers = await UserRepository().getHeaders();
      print("$url \n $headers");
      print("Payload");
      print(_mainTripSchedulePayload.toJson());
      print(json.encode(_mainTripSchedulePayload.toJson()));
      print("================End Trip Schedule API call====================");
      await http
          .post(
        url,
        headers: headers,
        body: json.encode(
          _mainTripSchedulePayload.toJson(),
        ),
      )
          .then((value) async {
        if (value.statusCode == 200) {
          return true;
        } else {
          print(value.body);
          return false;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
    return false;
  }

  generateOverflightMainPayload(
      List<TripSchedulePreOverflightPayload>? schedule) {
    if (schedule == null || schedule.length == 0) return [];
    var _overflights = [];
    for (TripSchedulePreOverflightPayload overflight in schedule) {
      var _overflightPayload = TripScheduleOverflight(
        code: overflight.code(),
        entryPoint: overflight.entryPoint(),
        exitPoint: overflight.exitPoint(),
        overflyCountry: overflight.countryName(),
        tripOverflyId: overflight.overflightId(),
        sequenceNum: overflight.sequenceNum(),
      );
      _overflights.add(_overflightPayload.toJson());
    }
    return _overflights;
  }
}
