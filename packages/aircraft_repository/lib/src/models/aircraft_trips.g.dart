// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aircraft_trips.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AircraftTrips _$AircraftTripsFromJson(Map<String, dynamic> json) =>
    AircraftTrips(
      acType: json['acType'] as String,
      aircraftId: json['aircraftId'] as int,
      aircraftTypeId: json['aircraftTypeId'] as int,
      callsign: json['callsign'] as String?,
      customer: json['customer'] as String?,
      customerId: json['customerId'] as int?,
      fileStatus: json['fileStatus'] as String?,
      tripId: json['tripId'] as int,
      tripNumber: json['tripNumber'] as String,
      tripStatus: json['tripStatus'] as String?,
      route:
          (json['route'] as List<dynamic>?)?.map((e) => e as String).toList(),
      operatorId: json['operatorId'] as int?,
      operator: json['operator'] as String?,
      regNo: json['regNo'] as String?,
      flightCategory: json['flightCategory'] as String,
      start: json['start'] as String?,
      end: json['end'] as String?,
    );

Map<String, dynamic> _$AircraftTripsToJson(AircraftTrips instance) =>
    <String, dynamic>{
      'acType': instance.acType,
      'aircraftId': instance.aircraftId,
      'aircraftTypeId': instance.aircraftTypeId,
      'callsign': instance.callsign,
      'customer': instance.customer,
      'customerId': instance.customerId,
      'fileStatus': instance.fileStatus,
      'tripId': instance.tripId,
      'tripNumber': instance.tripNumber,
      'tripStatus': instance.tripStatus,
      'route': instance.route,
      'operatorId': instance.operatorId,
      'operator': instance.operator,
      'regNo': instance.regNo,
      'flightCategory': instance.flightCategory,
      'start': instance.start,
      'end': instance.end,
    };
