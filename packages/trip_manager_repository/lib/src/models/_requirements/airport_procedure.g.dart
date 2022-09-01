// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport_procedure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirportProcedure _$AirportProcedureFromJson(Map<String, dynamic> json) =>
    AirportProcedure(
      id: json['id'] as int,
      airportId: json['airportId'] as int,
      businessType: json['businessType'] as String?,
      type: json['type'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$AirportProcedureToJson(AirportProcedure instance) =>
    <String, dynamic>{
      'id': instance.id,
      'airportId': instance.airportId,
      'businessType': instance.businessType,
      'type': instance.type,
      'notes': instance.notes,
    };
