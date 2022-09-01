// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_review_current_service_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripReviewCurrentServiceDetail _$TripReviewCurrentServiceDetailFromJson(
        Map<String, dynamic> json) =>
    TripReviewCurrentServiceDetail(
      serviceType: json['serviceType'] as String?,
      location: json['location'] as String?,
      seq: json['seq'] as String?,
      countryOrLoc: json['countryOrLoc'] as String?,
      on: json['on'] as String?,
      payment: json['payment'] as String?,
      through: json['through'] as String?,
      billable: json['billable'] as String?,
    );

Map<String, dynamic> _$TripReviewCurrentServiceDetailToJson(
        TripReviewCurrentServiceDetail instance) =>
    <String, dynamic>{
      'serviceType': instance.serviceType,
      'location': instance.location,
      'seq': instance.seq,
      'countryOrLoc': instance.countryOrLoc,
      'on': instance.on,
      'payment': instance.payment,
      'through': instance.through,
      'billable': instance.billable,
    };
