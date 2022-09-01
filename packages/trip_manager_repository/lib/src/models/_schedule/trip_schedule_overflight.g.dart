// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_schedule_overflight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripScheduleOverflight _$TripScheduleOverflightFromJson(
        Map<String, dynamic> json) =>
    TripScheduleOverflight(
      tripOverflyId: json['tripOverflyId'] as int?,
      overflyCountry: json['overflyCountry'] as String,
      entryPoint: json['EntryPoint'] as String,
      exitPoint: json['ExitPoint'] as String,
      code: json['code'] as String,
      sequenceNum: json['sequenceNum'] as int,
    );

Map<String, dynamic> _$TripScheduleOverflightToJson(
        TripScheduleOverflight instance) =>
    <String, dynamic>{
      'tripOverflyId': instance.tripOverflyId,
      'overflyCountry': instance.overflyCountry,
      'EntryPoint': instance.entryPoint,
      'ExitPoint': instance.exitPoint,
      'code': instance.code,
      'sequenceNum': instance.sequenceNum,
    };
