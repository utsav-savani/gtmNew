// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_review_current_pod_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripReviewCurrentPOBDetail _$TripReviewCurrentPOBDetailFromJson(
        Map<String, dynamic> json) =>
    TripReviewCurrentPOBDetail(
      depApt: json['depApt'] as String?,
      etd: json['etd'] as String?,
      tripsequenceNumber: json['tripsequenceNumber'] as int?,
      pobDetails: (json['pobDetails'] as List<dynamic>?)
          ?.map((e) => TripReviewCurrentPOBDetailedDetail.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TripReviewCurrentPOBDetailToJson(
        TripReviewCurrentPOBDetail instance) =>
    <String, dynamic>{
      'depApt': instance.depApt,
      'etd': instance.etd,
      'tripsequenceNumber': instance.tripsequenceNumber,
      'pobDetails': instance.pobDetails?.map((e) => e.toJson()).toList(),
    };
