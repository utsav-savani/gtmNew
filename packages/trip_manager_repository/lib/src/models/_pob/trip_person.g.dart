// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripPerson _$TripPersonFromJson(Map<String, dynamic> json) => TripPerson(
      personId: json['personId'] as int,
      name: json['name'] as String,
      nationality: json['nationality'] as String,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      passport: (json['passport'] as List<dynamic>?)
          ?.map((e) => Passport.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TripPersonToJson(TripPerson instance) =>
    <String, dynamic>{
      'personId': instance.personId,
      'name': instance.name,
      'roles': instance.roles,
      'nationality': instance.nationality,
      'passport': instance.passport?.map((e) => e.toJson()).toList(),
    };
