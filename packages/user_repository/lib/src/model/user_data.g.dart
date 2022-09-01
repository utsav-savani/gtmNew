// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataObject _$UserDataObjectFromJson(Map<String, dynamic> json) =>
    UserDataObject(
      userId: json['userId'] as String,
      emailAddress: json['emailAddress'] as String? ?? '',
      isBDM: json['isBDM'] as bool? ?? false,
      isInternal: json['isInternal'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      timeZone: json['timeZone'] as String? ?? '',
      domainId: json['domainId'] as String? ?? '',
      domainLogin: json['domainLogin'] as String? ?? '',
      lastSignIn: json['lastSignIn'] as String? ?? '',
      description: json['description'] as String? ?? '',
      jobtitle: json['jobtitle'] as String? ?? '',
      department: json['department'] as String? ?? '',
      streetaddress: json['streetaddress'] as String? ?? '',
      city: json['city'] as String? ?? '',
      zipcode: json['zipcode'] as String? ?? '',
      country: json['country'] as String? ?? '',
      officephone: json['officephone'] as String? ?? '',
      office: json['office'] as String? ?? '',
      mobilephone: json['mobilephone'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      status: json['status'] as bool? ?? false,
      offices: (json['Offices'] as List<dynamic>?)
              ?.map((e) => Office.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      customers: (json['customers'] as List<dynamic>?)
              ?.map((e) => Customer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserDataObjectToJson(UserDataObject instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'emailAddress': instance.emailAddress,
      'status': instance.status,
      'isBDM': instance.isBDM,
      'isInternal': instance.isInternal,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'timeZone': instance.timeZone,
      'domainId': instance.domainId,
      'domainLogin': instance.domainLogin,
      'lastSignIn': instance.lastSignIn,
      'description': instance.description,
      'jobtitle': instance.jobtitle,
      'department': instance.department,
      'streetaddress': instance.streetaddress,
      'city': instance.city,
      'zipcode': instance.zipcode,
      'country': instance.country,
      'officephone': instance.officephone,
      'office': instance.office,
      'mobilephone': instance.mobilephone,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'Offices': instance.offices.map((e) => e.toJson()).toList(),
      'customers': instance.customers.map((e) => e.toJson()).toList(),
    };
