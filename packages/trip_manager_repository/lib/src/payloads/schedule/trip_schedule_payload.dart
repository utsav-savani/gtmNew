import 'package:trip_manager_repository/json/json_convertible.dart';

class TripSchedulePayload implements JSONConvertible {
  final eTATBA;
  final eTDTBA;
  final isETAUTC;
  final isETDUTC;
  final isETD;
  final isETA;
  final isRepeatSequence;
  final tripScheduleId;
  final airportId;
  final flightCategoryId;
  final flightPurposeId;
  final eTDStatus;
  final eTAStatus;
  final callSign;
  final aTCRoute;
  final arivaldeparturetype;
  final eTD;
  final eTA;
  final aTATime;
  final aTDTime;
  final eTE;
  final eTG;
  final tripsequenceNumber;
  final split;
  final previousSplit;
  final overflyCountry;

  TripSchedulePayload({
    this.aTATime,
    this.aTCRoute,
    this.aTDTime,
    this.airportId,
    this.arivaldeparturetype,
    this.callSign,
    this.eTA,
    this.eTAStatus,
    this.eTATBA,
    this.eTD,
    this.eTDStatus,
    this.eTDTBA,
    this.eTE,
    this.eTG,
    this.flightCategoryId,
    this.flightPurposeId,
    this.isETA,
    this.isETAUTC,
    this.isETD,
    this.isETDUTC,
    this.isRepeatSequence,
    this.previousSplit,
    this.split,
    this.tripScheduleId,
    this.tripsequenceNumber,
    this.overflyCountry,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "ETATBA": eTATBA,
      "ETDTBA": eTDTBA,
      "IsETAUTC": isETAUTC,
      "IsETDUTC": isETDUTC,
      "isETD": isETD,
      "isETA": isETA,
      "isRepeatSequence": isRepeatSequence,
      "tripScheduleId": tripScheduleId,
      "airportId": airportId,
      "flightCategoryId": flightCategoryId,
      "flightPurposeId": flightPurposeId,
      "ETDStatus": eTDStatus,
      "ETAStatus": eTAStatus,
      "callSign": callSign,
      "ATCRoute": aTCRoute,
      "arivaldeparturetype": arivaldeparturetype,
      "ETD": eTD,
      "ETA": eTA,
      "ATATime": aTATime,
      "ATDTime": aTDTime,
      "ETE": eTE,
      "ETG": eTG,
      "tripsequenceNumber": tripsequenceNumber,
      "split": split,
      "previousSplit": previousSplit,
      "overflyCountry": overflyCountry,
    };
  }
}
