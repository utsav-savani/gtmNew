// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vendor _$VendorFromJson(Map<String, dynamic> json) => Vendor(
      fullName: json['fullName'] as String?,
      vendor: json['vendor'] as String?,
      email:
          (json['email'] as List<dynamic>?)?.map((e) => e as String).toList(),
      fax: (json['fax'] as List<dynamic>?)?.map((e) => e as String).toList(),
      phone:
          (json['phone'] as List<dynamic>?)?.map((e) => e as String).toList(),
      mobile:
          (json['mobile'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$VendorToJson(Vendor instance) => <String, dynamic>{
      'fullName': instance.fullName,
      'vendor': instance.vendor,
      'email': instance.email,
      'fax': instance.fax,
      'phone': instance.phone,
      'mobile': instance.mobile,
    };
