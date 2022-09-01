// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport_attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirportAttachment _$AirportAttachmentFromJson(Map<String, dynamic> json) =>
    AirportAttachment(
      id: json['id'] as int,
      airportId: json['airportId'] as int,
      storedName: json['storedName'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$AirportAttachmentToJson(AirportAttachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'airportId': instance.airportId,
      'storedName': instance.storedName,
      'name': instance.name,
    };
