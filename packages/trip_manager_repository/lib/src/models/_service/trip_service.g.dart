// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripService _$TripServiceFromJson(Map<String, dynamic> json) => TripService(
      tripOverflyServiceId: json['tripOverflyServiceId'] as int?,
      tripServiceId: json['tripServiceId'] as int?,
      serviceId: json['serviceId'] as int?,
      vendorId: json['vendorId'] as int?,
      through: json['through'] as String?,
      serviceStatus: json['serviceStatus'] as String?,
      scheduleStatus: json['scheduleStatus'] as String?,
      serviceCode: json['serviceCode'] as String?,
      service: json['service'] as String?,
      status: json['status'] as String?,
      isRemovable: json['isRemovable'] as bool?,
    );

Map<String, dynamic> _$TripServiceToJson(TripService instance) =>
    <String, dynamic>{
      'tripOverflyServiceId': instance.tripOverflyServiceId,
      'tripServiceId': instance.tripServiceId,
      'serviceId': instance.serviceId,
      'vendorId': instance.vendorId,
      'through': instance.through,
      'serviceStatus': instance.serviceStatus,
      'scheduleStatus': instance.scheduleStatus,
      'serviceCode': instance.serviceCode,
      'service': instance.service,
      'status': instance.status,
      'isRemovable': instance.isRemovable,
    };
