// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonContact _$PersonContactFromJson(Map<String, dynamic> json) =>
    PersonContact()
      ..mobile = json['mobile'] as String?
      ..email = json['email'] as String?
      ..phone = json['phone'] as String?;

Map<String, dynamic> _$PersonContactToJson(PersonContact instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
      'email': instance.email,
      'phone': instance.phone,
    };
