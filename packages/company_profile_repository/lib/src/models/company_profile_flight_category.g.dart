// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_profile_flight_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyProfileFlightCategory _$CompanyProfileFlightCategoryFromJson(
        Map<String, dynamic> json) =>
    CompanyProfileFlightCategory(
      flightCategoryId: json['flightCategoryId'] as int,
      customerId: json['customerId'] as int,
      flightCategory: json['FlightCategory'] == null
          ? null
          : FlightCategory.fromJson(
              json['FlightCategory'] as Map<String, dynamic>),
      category: json['category'] as String?,
    );

Map<String, dynamic> _$CompanyProfileFlightCategoryToJson(
        CompanyProfileFlightCategory instance) =>
    <String, dynamic>{
      'flightCategoryId': instance.flightCategoryId,
      'customerId': instance.customerId,
      'FlightCategory': instance.flightCategory?.toJson(),
      'category': instance.category,
    };
