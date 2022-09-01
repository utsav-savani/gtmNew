// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customers _$CustomersFromJson(Map<String, dynamic> json) => Customers(
      customerId: json['customerId'] as int,
      name: json['name'] as String?,
      organizationId: json['organizationId'] as int?,
      customerName: json['customerName'] as String?,
    );

Map<String, dynamic> _$CustomersToJson(Customers instance) => <String, dynamic>{
      'customerId': instance.customerId,
      'name': instance.name,
      'customerName': instance.customerName,
      'organizationId': instance.organizationId,
    };
