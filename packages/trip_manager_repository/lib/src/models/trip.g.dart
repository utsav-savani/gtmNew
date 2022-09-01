// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trip _$TripFromJson(Map<String, dynamic> json) => Trip(
      tripId: json['tripId'] as int,
      guid: json['guid'] as String,
      tripNumber: json['tripNumber'] as String,
      tripStatus: json['tripStatus'] as String,
      fileStatus: json['fileStatus'] as String,
      customerId: json['customerId'] as int,
      customer: json['customer'] as String,
      regNo: json['regNo'] as String,
      operator: json['operator'] as String,
      acType: json['acType'] as String,
      team: json['team'] as String,
      isFlightCategory: json['isFlightCategory'] as bool,
      flightCategory: json['flightCategory'] as String,
      callsign: json['callsign'] as String,
      start: json['start'] as String,
      end: json['end'] as String,
      route:
          (json['route'] as List<dynamic>?)?.map((e) => e as String).toList(),
      creator: json['creator'] as String,
    );

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
      'tripId': instance.tripId,
      'guid': instance.guid,
      'tripNumber': instance.tripNumber,
      'tripStatus': instance.tripStatus,
      'fileStatus': instance.fileStatus,
      'customerId': instance.customerId,
      'customer': instance.customer,
      'regNo': instance.regNo,
      'operator': instance.operator,
      'acType': instance.acType,
      'team': instance.team,
      'isFlightCategory': instance.isFlightCategory,
      'flightCategory': instance.flightCategory,
      'callsign': instance.callsign,
      'start': instance.start,
      'end': instance.end,
      'route': instance.route,
      'creator': instance.creator,
    };
