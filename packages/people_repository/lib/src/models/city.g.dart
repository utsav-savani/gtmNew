// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

City _$CityFromJson(Map<String, dynamic> json) => City(
      json['cityId'] as int,
      json['city'] as String,
      json['country'] as String,
    );

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'cityId': instance.cityId,
      'city': instance.city,
      'country': instance.country,
    };
