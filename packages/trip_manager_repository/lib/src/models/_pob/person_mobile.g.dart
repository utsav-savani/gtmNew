// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_mobile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonMobile _$PersonMobileFromJson(Map<String, dynamic> json) => PersonMobile(
      personMobileId: json['personMobileId'] as int?,
      personId: json['personId'] as int?,
      mobile: json['mobile'] as String?,
    );

Map<String, dynamic> _$PersonMobileToJson(PersonMobile instance) =>
    <String, dynamic>{
      'personMobileId': instance.personMobileId,
      'personId': instance.personId,
      'mobile': instance.mobile,
    };
