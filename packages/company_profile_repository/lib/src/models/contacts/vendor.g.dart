// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vendor _$VendorFromJson(Map<String, dynamic> json) => Vendor(
      vendorId: json['vendorId'] as int,
      name: json['name'] as String,
      fullName: json['fullName'] as String?,
    );

Map<String, dynamic> _$VendorToJson(Vendor instance) => <String, dynamic>{
      'vendorId': instance.vendorId,
      'name': instance.name,
      'fullName': instance.fullName,
    };
