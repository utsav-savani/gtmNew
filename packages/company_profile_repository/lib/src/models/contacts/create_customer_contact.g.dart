// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_customer_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCustomerContact _$CreateCustomerContactFromJson(
        Map<String, dynamic> json) =>
    CreateCustomerContact(
      customerId: json['customerId'] as int?,
      customercontactId: json['customercontactId'] as int?,
      name: json['Name'] as String,
      priority: json['Priority'] as int,
      contactType: json['contactType'] as String,
      contactInfos: (json['ContactInfo'] as List<dynamic>)
          .map((e) => ContactInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      customerIds: (json['CustomerIds'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      vendorIds:
          (json['VendorIds'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$CreateCustomerContactToJson(
        CreateCustomerContact instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'customercontactId': instance.customercontactId,
      'Name': instance.name,
      'Priority': instance.priority,
      'contactType': instance.contactType,
      'ContactInfo': instance.contactInfos.map((e) => e.toJson()).toList(),
      'CustomerIds': instance.customerIds,
      'VendorIds': instance.vendorIds,
    };
