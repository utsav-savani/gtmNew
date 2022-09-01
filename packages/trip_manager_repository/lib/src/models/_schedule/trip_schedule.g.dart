// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripSchedule _$TripScheduleFromJson(Map<String, dynamic> json) => TripSchedule(
      airportId: json['airportId'] as int?,
      archived: json['archived'] as bool?,
      arivaldeparturetype: json['arivaldeparturetype'] as int?,
      callSign: json['callSign'] as String?,
      createdAt: json['createdAt'] as String?,
      eTAStatus: json['ETAStatus'] as String?,
      eTATBA: json['ETATBA'] as bool?,
      eTDStatus: json['ETDStatus'] as String?,
      eTDTBA: json['ETDTBA'] as bool?,
      flightCategoryId: json['flightCategoryId'] as int?,
      flightPurposeId: json['flightPurposeId'] as int?,
      isETA: json['isETA'] as bool?,
      isETAUTC: json['IsETAUTC'] as bool?,
      isETD: json['isETD'] as bool?,
      isETDUTC: json['IsETDUTC'] as bool?,
      isRepeatSequence: json['isRepeatSequence'] as bool?,
      previousSplit: json['previousSplit'] as bool?,
      split: json['split'] as bool?,
      tripId: json['tripId'] as int?,
      tripScheduleId: json['tripScheduleId'] as int?,
      tripsequenceNumber: json['tripsequenceNumber'] as int?,
      updatedAt: json['updatedAt'] as String?,
      eTA: json['ETA'] as String?,
      eTD: json['ETD'] as String?,
      aTATime: json['ATATime'] as String?,
      aTCRoute: json['ATCRoute'] as String?,
      aTDTime: json['ATDTime'] as String?,
      eTE: json['ETE'] as String?,
      eTG: json['ETG'] as String?,
      noofCrews: json['NoofCrews'] as int?,
      noofPassengers: json['NoofPassengers'] as int?,
      tripAirports: json['tripAirports'] == null
          ? null
          : Airport.fromJson(json['tripAirports'] as Map<String, dynamic>),
      tripScheduleFlightCategory: json['tripScheduleFlightCategory'] == null
          ? null
          : FlightCategory.fromJson(
              json['tripScheduleFlightCategory'] as Map<String, dynamic>),
      tripFlightPurpuses: json['tripFlightPurpuses'] == null
          ? null
          : FlightPurpose.fromJson(
              json['tripFlightPurpuses'] as Map<String, dynamic>),
      tripScheduleOverflyCountry: (json['tripScheduleOverflyCountry']
              as List<dynamic>?)
          ?.map(
              (e) => TripScheduleOverflight.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TripScheduleToJson(TripSchedule instance) =>
    <String, dynamic>{
      'tripScheduleId': instance.tripScheduleId,
      'tripId': instance.tripId,
      'tripsequenceNumber': instance.tripsequenceNumber,
      'arivaldeparturetype': instance.arivaldeparturetype,
      'flightCategoryId': instance.flightCategoryId,
      'airportId': instance.airportId,
      'flightPurposeId': instance.flightPurposeId,
      'callSign': instance.callSign,
      'ETA': instance.eTA,
      'ETD': instance.eTD,
      'ETATBA': instance.eTATBA,
      'ETDTBA': instance.eTDTBA,
      'ETE': instance.eTE,
      'ETG': instance.eTG,
      'IsETAUTC': instance.isETAUTC,
      'IsETDUTC': instance.isETDUTC,
      'ETAStatus': instance.eTAStatus,
      'ETDStatus': instance.eTDStatus,
      'ATCRoute': instance.aTCRoute,
      'NoofPassengers': instance.noofPassengers,
      'NoofCrews': instance.noofCrews,
      'isETD': instance.isETD,
      'ATDTime': instance.aTDTime,
      'ATATime': instance.aTATime,
      'isETA': instance.isETA,
      'isRepeatSequence': instance.isRepeatSequence,
      'split': instance.split,
      'previousSplit': instance.previousSplit,
      'archived': instance.archived,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'tripAirports': instance.tripAirports?.toJson(),
      'tripScheduleFlightCategory':
          instance.tripScheduleFlightCategory?.toJson(),
      'tripFlightPurpuses': instance.tripFlightPurpuses?.toJson(),
      'tripScheduleOverflyCountry':
          instance.tripScheduleOverflyCountry?.map((e) => e.toJson()).toList(),
    };
