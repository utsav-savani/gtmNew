// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUser _$AuthUserFromJson(Map<String, dynamic> json) => AuthUser(
      userId: json['userId'] as String,
      emailAddress: json['emailAddress'] as String? ?? '',
      status: json['status'] as bool? ?? false,
      isBDM: json['isBDM'] as bool? ?? false,
      isInternal: json['isInternal'] as bool? ?? false,
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      timeZone: json['timeZone'] as String? ?? '',
      domainId: json['domainId'] as String? ?? '',
      domainLogin: json['domainLogin'] as String? ?? '',
      lastSignIn: json['lastSignIn'] == null
          ? null
          : DateTime.parse(json['lastSignIn'] as String),
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
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$AuthUserToJson(AuthUser instance) => <String, dynamic>{
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
      'lastSignIn': instance.lastSignIn?.toIso8601String(),
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
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
