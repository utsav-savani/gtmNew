// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_review_flight_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripReviewFlightDetail _$TripReviewFlightDetailFromJson(
        Map<String, dynamic> json) =>
    TripReviewFlightDetail(
      arrApt: json['arrApt'] as String?,
      callSign: json['callSign'] as String?,
      depApt: json['depApt'] as String?,
      eta: json['eta'] as String?,
      etd: json['etd'] as String?,
      etdFormat: json['etdFormat'] as String?,
      flightCategory: json['flightCategory'] as String?,
      purpose: json['purpose'] as String?,
      sectorSts: json['sectorSts'] as String?,
    );

Map<String, dynamic> _$TripReviewFlightDetailToJson(
        TripReviewFlightDetail instance) =>
    <String, dynamic>{
      'depApt': instance.depApt,
      'arrApt': instance.arrApt,
      'callSign': instance.callSign,
      'flightCategory': instance.flightCategory,
      'purpose': instance.purpose,
      'sectorSts': instance.sectorSts,
      'etd': instance.etd,
      'eta': instance.eta,
      'etdFormat': instance.etdFormat,
    };
