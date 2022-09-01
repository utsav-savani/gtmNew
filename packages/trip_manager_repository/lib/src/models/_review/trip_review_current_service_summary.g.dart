// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_review_current_service_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripReviewCurrentServiceSummary _$TripReviewCurrentServiceSummaryFromJson(
        Map<String, dynamic> json) =>
    TripReviewCurrentServiceSummary(
      departure: json['departure'] as String?,
      arrival: json['arrival'] as String?,
      index: json['index'] as int?,
      total: json['total'] as String?,
      serviceDetails: (json['serviceDetails'] as List<dynamic>?)
          ?.map((e) => TripReviewCurrentServiceDetail.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TripReviewCurrentServiceSummaryToJson(
        TripReviewCurrentServiceSummary instance) =>
    <String, dynamic>{
      'departure': instance.departure,
      'arrival': instance.arrival,
      'index': instance.index,
      'total': instance.total,
      'serviceDetails':
          instance.serviceDetails?.map((e) => e.toJson()).toList(),
    };
