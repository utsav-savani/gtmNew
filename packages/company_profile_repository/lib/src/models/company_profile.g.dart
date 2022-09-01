// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyProfile _$CompanyProfileFromJson(Map<String, dynamic> json) =>
    CompanyProfile(
      customerId: json['customerId'] as int,
      organizationId: json['organizationId'] as int,
      accountingStatus: json['accountingStatus'] as String?,
      status: json['status'] as String?,
      cicCategory: json['cicCategory'] as String?,
      permitOverride: json['permitOverride'] as String?,
      notes: json['notes'] as String?,
      SeeNote: json['SeeNote'] as String?,
      customerName: json['customerName'] as String?,
      countryId: json['countryId'] as int?,
      regionName: json['regionName'] as String?,
      website: json['website'] as String?,
      billingAddress: json['billingAddress'] as String?,
      officeId: json['officeId'] as int?,
      bdm: (json['bdm'] as List<dynamic>?)
          ?.map((e) => Bdm.fromJson(e as Map<String, dynamic>))
          .toList(),
      bdmList:
          (json['bdmList'] as List<dynamic>?)?.map((e) => e as String).toList(),
      country: json['CustomerCountry'] == null
          ? null
          : Country.fromJson(json['CustomerCountry'] as Map<String, dynamic>),
      customerType: (json['CustomerHasTypesList'] as List<dynamic>?)
          ?.map((e) => CustomerType.fromJson(e as Map<String, dynamic>))
          .toList(),
      offices:
          (json['offices'] as List<dynamic>?)?.map((e) => e as String).toList(),
      teams: (json['teams'] as List<dynamic>?)
          ?.map((e) => Teams.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompanyProfileToJson(CompanyProfile instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'organizationId': instance.organizationId,
      'accountingStatus': instance.accountingStatus,
      'status': instance.status,
      'cicCategory': instance.cicCategory,
      'permitOverride': instance.permitOverride,
      'notes': instance.notes,
      'SeeNote': instance.SeeNote,
      'customerName': instance.customerName,
      'countryId': instance.countryId,
      'regionName': instance.regionName,
      'website': instance.website,
      'billingAddress': instance.billingAddress,
      'officeId': instance.officeId,
      'CustomerHasTypesList':
          instance.customerType?.map((e) => e.toJson()).toList(),
      'CustomerCountry': instance.country?.toJson(),
      'offices': instance.offices,
      'teams': instance.teams?.map((e) => e.toJson()).toList(),
      'bdm': instance.bdm?.map((e) => e.toJson()).toList(),
      'bdmList': instance.bdmList,
    };
