// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_manager_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripManagerReview _$TripManagerReviewFromJson(Map<String, dynamic> json) =>
    TripManagerReview(
      tripNumber: json['tripNumber'] as String?,
      acReg: json['acReg'] as String?,
      acType: json['acType'] as String?,
      createdBy: json['createdBy'] as String?,
      customer: json['customer'] as String?,
      mtow: json['mtow'] as String?,
      officeId: json['officeId'] as int?,
      operator: json['operator'] as String?,
      reference: json['reference'] as String?,
      requested: json['requested'] as String?,
      timeFormat: json['timeFormat'] as String?,
      subAircrafts: (json['subAircrafts'] as List<dynamic>)
          .map((e) => TripReviewSubaircraft.fromJson(e as Map<String, dynamic>))
          .toList(),
      flightDetails: (json['flightDetails'] as List<dynamic>)
          .map(
              (e) => TripReviewFlightDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentServiceSummary: (json['currentServiceSummary'] as List<dynamic>)
          .map((e) => TripReviewCurrentServiceSummary.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      currentPOBDetails: (json['currentPOBDetails'] as List<dynamic>)
          .map((e) =>
              TripReviewCurrentPOBDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      fileName: json['fileName'] as String?,
    );

Map<String, dynamic> _$TripManagerReviewToJson(TripManagerReview instance) =>
    <String, dynamic>{
      'tripNumber': instance.tripNumber,
      'officeId': instance.officeId,
      'customer': instance.customer,
      'operator': instance.operator,
      'createdBy': instance.createdBy,
      'requested': instance.requested,
      'reference': instance.reference,
      'acReg': instance.acReg,
      'acType': instance.acType,
      'mtow': instance.mtow,
      'timeFormat': instance.timeFormat,
      'fileName': instance.fileName,
      'subAircrafts': instance.subAircrafts.map((e) => e.toJson()).toList(),
      'flightDetails': instance.flightDetails.map((e) => e.toJson()).toList(),
      'currentServiceSummary':
          instance.currentServiceSummary.map((e) => e.toJson()).toList(),
      'currentPOBDetails':
          instance.currentPOBDetails.map((e) => e.toJson()).toList(),
    };
