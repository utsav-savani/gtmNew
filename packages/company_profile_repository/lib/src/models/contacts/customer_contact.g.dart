// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerContact _$CustomerContactFromJson(Map<String, dynamic> json) =>
    CustomerContact(
      customercontactId: json['customercontactId'] as int,
      customerId: json['customerId'] as int?,
      name: json['Name'] as String,
      contactType: json['contactType'] as String,
      customerContactTypeInfo:
          (json['CustomerContactTypeInfo'] as List<dynamic>)
              .map((e) =>
                  CustomerContactTypeInfo.fromJson(e as Map<String, dynamic>))
              .toList(),
      callRecords: (json['callRecords'] as List<dynamic>)
          .map((e) => CallRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      priority: json['priority'] as int,
      linkedCustomers: (json['linkedCustomers'] as List<dynamic>?)
          ?.map((e) => Customers.fromJson(e as Map<String, dynamic>))
          .toList(),
      linkedVendors: (json['linkedVendors'] as List<dynamic>?)
          ?.map((e) => Vendor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomerContactToJson(CustomerContact instance) =>
    <String, dynamic>{
      'customercontactId': instance.customercontactId,
      'customerId': instance.customerId,
      'priority': instance.priority,
      'Name': instance.name,
      'contactType': instance.contactType,
      'CustomerContactTypeInfo':
          instance.customerContactTypeInfo.map((e) => e.toJson()).toList(),
      'callRecords': instance.callRecords.map((e) => e.toJson()).toList(),
      'linkedCustomers':
          instance.linkedCustomers?.map((e) => e.toJson()).toList(),
      'linkedVendors': instance.linkedVendors?.map((e) => e.toJson()).toList(),
    };
