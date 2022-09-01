// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightCategory _$FlightCategoryFromJson(Map<String, dynamic> json) =>
    FlightCategory(
      category: json['category'] as String?,
      flightCategoryId: json['flightCategoryId'] as int?,
    );

Map<String, dynamic> _$FlightCategoryToJson(FlightCategory instance) =>
    <String, dynamic>{
      'category': instance.category,
      'flightCategoryId': instance.flightCategoryId,
    };
