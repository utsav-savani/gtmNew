// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pob_customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PobCustomer _$PobCustomerFromJson(Map<String, dynamic> json) => PobCustomer(
      customerId: json['customerId'] as int?,
      organizationId: json['organizationId'] as int?,
      customerName: json['customerName'] as String?,
    );

Map<String, dynamic> _$PobCustomerToJson(PobCustomer instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'organizationId': instance.organizationId,
      'customerName': instance.customerName,
    };
