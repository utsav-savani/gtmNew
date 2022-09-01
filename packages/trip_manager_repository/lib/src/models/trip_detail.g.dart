// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripDetail _$TripDetailFromJson(Map<String, dynamic> json) => TripDetail(
      tripNumber: json['tripNumber'] as String?,
      guid: json['guid'] as String?,
      customerId: json['customerId'] as int?,
      operatorId: json['operatorId'] as int?,
      isRevised: json['isRevised'] as bool?,
      tCERef: json['TCERef'] as String?,
      isPullForBilling: json['isPullForBilling'] as bool?,
      flightCategoryId: json['flightCategoryId'] as int?,
      officeId: json['officeId'] as int?,
      primaryAircraftId: json['primaryAircraftId'] as int?,
      tripStatus: json['tripStatus'] as String?,
      fileStatus: json['fileStatus'] as String?,
      customerReference: json['customerReference'] as String?,
      createdAt: json['createdAt'] as String?,
      tripOwnerId: json['tripOwnerId'] as String?,
      tripCostEstimate: json['tripCostEstimate'] as bool?,
      operatorName: json['operatorName'] as String?,
      customerName: json['customerName'] as String?,
      tripOwnerName: json['tripOwnerName'] as String?,
      accountStatus: json['accountStatus'] as String?,
      officeName: json['officeName'] as String?,
      officeFullName: json['officeFullName'] as String?,
      primaryAircraft: json['primaryAircraft'] == null
          ? null
          : PrimaryAircraft.fromJson(
              json['primaryAircraft'] as Map<String, dynamic>),
      childAircraft: (json['childAircraft'] as List<dynamic>?)
          ?.map((e) => PrimaryAircraft.fromJson(e as Map<String, dynamic>))
          .toList(),
      operationalNotes: (json['OperationalNotes'] as List<dynamic>?)
          ?.map((e) => OperationalNote.fromJson(e as Map<String, dynamic>))
          .toList(),
      pOCContact: (json['POCContact'] as List<dynamic>?)
          ?.map((e) => TripPOCContact.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TripDetailToJson(TripDetail instance) =>
    <String, dynamic>{
      'tripNumber': instance.tripNumber,
      'customerId': instance.customerId,
      'operatorId': instance.operatorId,
      'isRevised': instance.isRevised,
      'guid': instance.guid,
      'TCERef': instance.tCERef,
      'isPullForBilling': instance.isPullForBilling,
      'flightCategoryId': instance.flightCategoryId,
      'officeId': instance.officeId,
      'primaryAircraftId': instance.primaryAircraftId,
      'tripStatus': instance.tripStatus,
      'fileStatus': instance.fileStatus,
      'customerReference': instance.customerReference,
      'createdAt': instance.createdAt,
      'tripOwnerId': instance.tripOwnerId,
      'tripCostEstimate': instance.tripCostEstimate,
      'operatorName': instance.operatorName,
      'customerName': instance.customerName,
      'tripOwnerName': instance.tripOwnerName,
      'accountStatus': instance.accountStatus,
      'officeName': instance.officeName,
      'officeFullName': instance.officeFullName,
      'primaryAircraft': instance.primaryAircraft?.toJson(),
      'childAircraft': instance.childAircraft?.map((e) => e.toJson()).toList(),
      'OperationalNotes':
          instance.operationalNotes?.map((e) => e.toJson()).toList(),
      'POCContact': instance.pOCContact?.map((e) => e.toJson()).toList(),
    };
