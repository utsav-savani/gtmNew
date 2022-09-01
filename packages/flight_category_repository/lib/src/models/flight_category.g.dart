// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightCategory _$FlightCategoryFromJson(Map<String, dynamic> json) =>
    FlightCategory(
      flightCategoryId: json['flightCategoryId'] as int,
      category: json['category'] as String,
      customerId: json['customerId'] as int?,
    );

Map<String, dynamic> _$FlightCategoryToJson(FlightCategory instance) =>
    <String, dynamic>{
      'flightCategoryId': instance.flightCategoryId,
      'category': instance.category,
      'customerId': instance.customerId,
    };
