// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripDataResponse _$TripDataResponseFromJson(Map<String, dynamic> json) =>
    TripDataResponse(
      message: json['message'] as String?,
      isPullForBilling: json['isPullForBilling'] as bool?,
      isRevised: json['isRevised'] as bool?,
      tripCostEstimate: json['tripCostEstimate'] as bool?,
      fileStatus: json['fileStatus'] as String?,
      tripId: json['tripId'] as int?,
      officeId: json['officeId'] as int?,
      customerId: json['customerId'] as int?,
      flightCategoryId: json['flightCategoryId'] as int?,
      aircraftId: json['aircraftId'] as int?,
      operatorId: json['operatorId'] as int?,
      customerReference: json['customerReference'] as String?,
      linemode: json['linemode'] as String?,
      tripStatus: json['tripStatus'] as String?,
      creatorId: json['creatorId'] as String?,
      tripNumber: json['tripNumber'] as String?,
      guid: json['guid'] as String?,
      updatedAt: json['updatedAt'] as String?,
      createdAt: json['createdAt'] as String?,
      oldTripStatus: json['TCERef'] as bool?,
      serviceList: json['serviceList'] as String?,
      tCERef: json['tCERef'] as String?,
    );

Map<String, dynamic> _$TripDataResponseToJson(TripDataResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'isPullForBilling': instance.isPullForBilling,
      'isRevised': instance.isRevised,
      'tripCostEstimate': instance.tripCostEstimate,
      'fileStatus': instance.fileStatus,
      'tripId': instance.tripId,
      'officeId': instance.officeId,
      'customerId': instance.customerId,
      'flightCategoryId': instance.flightCategoryId,
      'aircraftId': instance.aircraftId,
      'operatorId': instance.operatorId,
      'customerReference': instance.customerReference,
      'linemode': instance.linemode,
      'tripStatus': instance.tripStatus,
      'creatorId': instance.creatorId,
      'tripNumber': instance.tripNumber,
      'guid': instance.guid,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
      'TCERef': instance.oldTripStatus,
      'tCERef': instance.tCERef,
      'serviceList': instance.serviceList,
    };
