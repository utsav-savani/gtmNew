// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport_city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirportCity _$AirportCityFromJson(Map<String, dynamic> json) => AirportCity(
      cityId: json['cityId'] as int?,
      country: json['country'] as String?,
      city: json['city'] as String?,
    );

Map<String, dynamic> _$AirportCityToJson(AirportCity instance) =>
    <String, dynamic>{
      'cityId': instance.cityId,
      'city': instance.city,
      'country': instance.country,
    };
