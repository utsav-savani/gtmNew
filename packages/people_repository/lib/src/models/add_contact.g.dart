// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddContact _$AddContactFromJson(Map<String, dynamic> json) => AddContact(
      email:
          (json['email'] as List<dynamic>?)?.map((e) => e as String).toList(),
      mobile:
          (json['mobile'] as List<dynamic>?)?.map((e) => e as String).toList(),
      phone:
          (json['phone'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AddContactToJson(AddContact instance) =>
    <String, dynamic>{
      'email': instance.email,
      'mobile': instance.mobile,
      'phone': instance.phone,
    };
