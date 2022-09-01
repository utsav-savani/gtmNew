// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_purpose.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightPurpose _$FlightPurposeFromJson(Map<String, dynamic> json) =>
    FlightPurpose(
      flightPurposeId: json['flightPurposeId'] as int,
      flightPurpose: json['flightPurpose'] as String,
    );

Map<String, dynamic> _$FlightPurposeToJson(FlightPurpose instance) =>
    <String, dynamic>{
      'flightPurposeId': instance.flightPurposeId,
      'flightPurpose': instance.flightPurpose,
    };
