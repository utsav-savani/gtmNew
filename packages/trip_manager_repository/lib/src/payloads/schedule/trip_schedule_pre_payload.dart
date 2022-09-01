import 'package:airport_repository/airport_repository.dart';
import 'package:flight_category_repository/flight_category_repository.dart';
import 'package:flight_purpose_repository/flight_purpose_repository.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripSchedulePrePayload {
  int? _tripScheduleId;
  int? _airportId;
  int? _flightCategoryId;
  int? _purposeId;
  FlightPurpose? _purpose;
  String? _callsign;
  String? _atcrte;
  bool _atcrteDisplay = false;
  bool _isUTC = true;
  //ETD
  String? _etd;
  bool? _isETD;
  String? _etdLocal;

  String? _eta;
  String? _etaLocal;
  String? _etg;
  String? _ete;
  bool _isETEFieldDisabled = false;
  bool _split = false;
  bool _splitPrevious = false;
  bool _isAirportEditable = false;
  bool _isDeparture = false;
  bool _isArrival = false;
  bool _isETDTBA = false;
  bool _isETATBA = false;
  String? _eTAStatus;
  String? _eTDStatus;
  Airport? _airport;
  FlightCategory? _flightCategory;

  bool? _isETA;
  String? _aTATime;

  bool _isETDUTC = true;
  String? _aTDTime;

  List<TripSchedulePreOverflightPayload>? _overflights =
      <TripSchedulePreOverflightPayload>[];

  void setTripScheduleId(value) => _tripScheduleId = value;
  void setAirportId(value) => _airportId = value;
  void setAirport(value) => _airport = value;
  void setCategory(value) => _flightCategory = value;
  void setCategoryId(value) => _flightCategoryId = value;
  void setPurposeId(value) => _purposeId = value;
  void setPurpose(value) => _purpose = value;
  void setCallsign(value) => _callsign = value.toString().toUpperCase();
  void setATCRTE(value) => _atcrte = value;
  void setATCRTEDisplay(value) => _atcrteDisplay = value;

  //ETD
  void setETD(value) => _etd = value;
  void setETDLocal(value) => _etdLocal = value;

  void setETALocal(value) => _etaLocal = value;
  void setETG(value) => _etg = value;
  void setETE(value) {
    _ete = value;
    _isETEFieldDisabled = false;
    if (value == null) _isETEFieldDisabled = true;
  }

  void setUTC(value) => _isUTC = value;
  void setDepartureArrival(value) {
    if (value > 0) {
      _isDeparture = value == 1 || value == 2;
      _isArrival = value == 2 || value == 3;
    }
  }

  void setIsETA(value) => _isETA = value ?? true;
  void setIsETATBA(value) => _isETATBA = value ?? false;
  void setETA(value) => _eta = value;
  void setATATime(value) => _aTATime = value;
  void setETAStatus(value) => _eTAStatus = value ?? "DRAFT";

  void setIsETD(value) => _isETD = value ?? false;
  void setIsETDTBA(value) => _isETDTBA = value ?? false;
  void setETDStatus(value) => _eTDStatus = value;
  void setATDTime(value) => _aTDTime = value;

  void setSplit(value) => _split = value ?? false;
  void setSplitPrevious(value) => _splitPrevious = value ?? false;
  void setIsAirportEditable(value) => _isAirportEditable = value ?? false;

  void setOverflight(value) => _overflights?.add(value);
  void updateOverflight(index, value) => _overflights?[index] = value;
  void setOverflights(value) => _overflights = value;

  tripScheduleId() => _tripScheduleId;
  airportId() => _airportId;
  airport() => _airport;
  airportValue() => _airport != null
      ? '${_airport!.iata ?? ''} | ${_airport!.icao ?? ''} (${_airport!.city ?? ''})'
      : '';
  airportAll() => _airport != null
      ? '${_airport!.iata ?? ''}|${_airport!.icao ?? ''} ${_airport!.name}'
      : '';
  flightCategoryId() => _flightCategoryId;
  flightCategory() => _flightCategory;
  purposeId() => _purposeId;
  purpose() => _purpose;
  callsign() => _callsign;
  atcrte() => _atcrte;
  atcrteDisplay() => _atcrteDisplay;

  // ETD
  etd() => _etd;
  etdLocal() => _etdLocal;
  isETD() => _isETD;

  etaLocal() => _etaLocal;
  etg() => _etg;
  ete() => _ete;
  isETEFieldDisabled() => _isETEFieldDisabled;
  isDeparture() => _isDeparture;
  isArrival() => _isArrival;
  isAirportEditable() => _isAirportEditable;
  split() => _split;
  splitPrevious() => _splitPrevious;
  isUTC() => _isUTC;
  isETDTBA() => _isETDTBA;
  isETATBA() => _isETATBA;
  overflights() => _overflights;
  eTAStatus() => _eTAStatus;
  eTDStatus() => _eTDStatus;

  isETA() => _isETA;
  eta() => _eta;
  aTATime() => _aTATime;

  aTDTime() => _aTDTime;
  isETDUTC() => _isETDUTC;
}
