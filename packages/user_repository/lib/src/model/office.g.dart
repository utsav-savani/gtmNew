// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Office _$OfficeFromJson(Map<String, dynamic> json) => Office(
      officeId: json['officeId'] as int,
      officeName: json['officeName'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      website: json['website'] as String,
      contact: json['contact'] as String,
      mobile: json['mobile'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$OfficeToJson(Office instance) => <String, dynamic>{
      'officeId': instance.officeId,
      'officeName': instance.officeName,
      'fullName': instance.fullName,
      'email': instance.email,
      'website': instance.website,
      'contact': instance.contact,
      'mobile': instance.mobile,
      'address': instance.address,
    };
