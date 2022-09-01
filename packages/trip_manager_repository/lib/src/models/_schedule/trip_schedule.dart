import 'package:airport_repository/airport_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flight_category_repository/flight_category_repository.dart';
import 'package:flight_purpose_repository/flight_purpose_repository.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';
import 'package:trip_manager_repository/src/models/_schedule/trip_schedule_overflight.dart';

part 'trip_schedule.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripSchedule extends Equatable {
  final int? tripScheduleId;
  final int? tripId;
  final int? tripsequenceNumber;
  final int? arivaldeparturetype;
  final int? flightCategoryId;
  final int? airportId;
  final int? flightPurposeId;
  final String? callSign;
  @JsonKey(name: 'ETA')
  final String? eTA;
  @JsonKey(name: 'ETD')
  final String? eTD;
  @JsonKey(name: 'ETATBA')
  final bool? eTATBA;
  @JsonKey(name: 'ETDTBA')
  final bool? eTDTBA;
  @JsonKey(name: 'ETE')
  final String? eTE;
  @JsonKey(name: 'ETG')
  final String? eTG;
  @JsonKey(name: 'IsETAUTC')
  final bool? isETAUTC;
  @JsonKey(name: 'IsETDUTC')
  final bool? isETDUTC;
  @JsonKey(name: 'ETAStatus')
  final String? eTAStatus;
  @JsonKey(name: 'ETDStatus')
  final String? eTDStatus;
  @JsonKey(name: 'ATCRoute')
  final String? aTCRoute;
  @JsonKey(name: 'NoofPassengers')
  final int? noofPassengers;
  @JsonKey(name: 'NoofCrews')
  final int? noofCrews;
  final bool? isETD;
  @JsonKey(name: 'ATDTime')
  final String? aTDTime;
  @JsonKey(name: 'ATATime')
  final String? aTATime;
  final bool? isETA;
  final bool? isRepeatSequence;
  final bool? split;
  final bool? previousSplit;
  final bool? archived;
  final String? createdAt;
  final String? updatedAt;
  final Airport? tripAirports;
  final FlightCategory? tripScheduleFlightCategory;
  final FlightPurpose? tripFlightPurpuses;
  final List<TripScheduleOverflight>? tripScheduleOverflyCountry;

  const TripSchedule({
    required this.airportId,
    required this.archived,
    required this.arivaldeparturetype,
    this.callSign,
    required this.createdAt,
    required this.eTAStatus,
    required this.eTATBA,
    required this.eTDStatus,
    required this.eTDTBA,
    required this.flightCategoryId,
    required this.flightPurposeId,
    required this.isETA,
    required this.isETAUTC,
    required this.isETD,
    required this.isETDUTC,
    required this.isRepeatSequence,
    required this.previousSplit,
    required this.split,
    required this.tripId,
    required this.tripScheduleId,
    required this.tripsequenceNumber,
    required this.updatedAt,
    this.eTA,
    this.eTD,
    this.aTATime,
    this.aTCRoute,
    this.aTDTime,
    this.eTE,
    this.eTG,
    this.noofCrews,
    this.noofPassengers,
    this.tripAirports,
    this.tripScheduleFlightCategory,
    this.tripFlightPurpuses,
    this.tripScheduleOverflyCountry,
  });

  TripSchedule copyWith({
    required int tripScheduleId,
    required int tripId,
    required int tripsequenceNumber,
    required int arivaldeparturetype,
    required int flightCategoryId,
    required int airportId,
    required int flightPurposeId,
    String? callSign,
    required bool eTATBA,
    required bool eTDTBA,
    required bool isETAUTC,
    required bool isETDUTC,
    required String eTAStatus,
    required String eTDStatus,
    required bool isETD,
    required bool isETA,
    required bool isRepeatSequence,
    required bool split,
    required bool previousSplit,
    required bool archived,
    String? createdAt,
    String? updatedAt,
    String? eTA,
    String? eTD,
    String? eTE,
    String? eTG,
    String? aTCRoute,
    int? noofPassengers,
    int? noofCrews,
    String? aTDTime,
    String? aTATime,
    Airport? tripAirports,
    FlightCategory? tripScheduleFlightCategory,
    FlightPurpose? tripFlightPurpuses,
    List<TripScheduleOverflight>? tripScheduleOverflyCountry,
  }) {
    return TripSchedule(
      aTCRoute: aTCRoute,
      aTDTime: aTDTime,
      airportId: airportId,
      archived: archived,
      arivaldeparturetype: arivaldeparturetype,
      callSign: callSign,
      createdAt: createdAt,
      eTA: eTA,
      eTAStatus: eTAStatus,
      eTATBA: eTATBA,
      eTD: eTD,
      eTDStatus: eTDStatus,
      eTDTBA: eTDTBA,
      eTE: eTE,
      eTG: eTG,
      flightCategoryId: flightCategoryId,
      flightPurposeId: flightPurposeId,
      isETA: isETA,
      isETAUTC: isETAUTC,
      isETD: isETD,
      isETDUTC: isETDUTC,
      isRepeatSequence: isRepeatSequence,
      noofPassengers: noofPassengers,
      previousSplit: previousSplit,
      split: split,
      tripId: tripId,
      tripScheduleId: tripScheduleId,
      tripsequenceNumber: tripsequenceNumber,
      updatedAt: updatedAt,
      aTATime: aTATime,
      noofCrews: noofCrews,
      tripAirports: tripAirports,
      tripScheduleFlightCategory: tripScheduleFlightCategory,
      tripFlightPurpuses: tripFlightPurpuses,
      tripScheduleOverflyCountry: tripScheduleOverflyCountry,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripSchedule].
  static TripSchedule fromJson(JsonMap json) => _$TripScheduleFromJson(json);

  /// Converts this [TripSchedule] into a [JsonMap].
  JsonMap toJson() => _$TripScheduleToJson(this);

  @override
  List<Object?> get props => [
        aTCRoute,
        aTDTime,
        airportId,
        archived,
        arivaldeparturetype,
        callSign,
        createdAt,
        eTA,
        eTAStatus,
        eTATBA,
        eTD,
        eTDStatus,
        eTDTBA,
        eTE,
        eTG,
        flightCategoryId,
        flightPurposeId,
        isETA,
        isETAUTC,
        isETD,
        isETDUTC,
        isRepeatSequence,
        noofPassengers,
        previousSplit,
        split,
        tripId,
        tripScheduleId,
        tripsequenceNumber,
        updatedAt,
        aTATime,
        noofCrews,
        tripAirports,
        tripScheduleFlightCategory,
        tripScheduleOverflyCountry,
      ];
}
