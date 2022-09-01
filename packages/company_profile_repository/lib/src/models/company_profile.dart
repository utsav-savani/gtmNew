import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:company_profile_repository/src/models/bdm.dart';
import 'package:company_profile_repository/src/models/customer_type.dart';
import 'package:company_profile_repository/src/models/teams.dart';
import 'package:country_repository/country_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company_profile.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class CompanyProfile extends Equatable {
  final int customerId;
  final int organizationId;
  final String? accountingStatus;
  final String? status;
  final String? cicCategory;
  final String? permitOverride;
  final String? notes;
  final String? SeeNote;
  final String? customerName;
  final int? countryId;
  final String? regionName;
  final String? website;
  final String? billingAddress;
  final int? officeId;
  @JsonKey(name: 'CustomerHasTypesList')
  final List<CustomerType>? customerType;
  @JsonKey(name: 'CustomerCountry')
  final Country? country;
  final List<String>? offices;
  final List<Teams>? teams;
  final List<Bdm>? bdm;
  final List<String>? bdmList;

  const CompanyProfile(
      {required this.customerId,
      required this.organizationId,
      String? this.accountingStatus,
      String? this.status,
      String? this.cicCategory,
      String? this.permitOverride,
      String? this.notes,
      String? this.SeeNote,
      String? this.customerName,
      int? this.countryId,
      String? this.regionName,
      String? this.website,
      String? this.billingAddress,
      int? this.officeId,
      List<Bdm>? this.bdm,
      List<String>? this.bdmList,
      Country? this.country,
      List<CustomerType>? this.customerType,
      List<String>? this.offices,
      List<Teams>? this.teams});

  CompanyProfile copyWith(
          {int? customerId,
          int? organizationId,
          String? accountingStatus,
          String? status,
          String? cicCategory,
          String? permitOverride,
          String? notes,
          String? SeeNote,
          String? customerName,
          int? countryId,
          String? regionName,
          String? website,
          String? billingAddress,
          int? officeId,
          List<Bdm>? bdm,
          List<String>? bdmList,
          Country? country,
          List<CustomerType>? customerType,
          List<String>? offices,
          List<Teams>? teams}) =>
      CompanyProfile(
          customerId: customerId ?? this.customerId,
          organizationId: organizationId ?? this.organizationId,
          accountingStatus: accountingStatus ?? this.accountingStatus,
          status: status ?? this.status,
          cicCategory: cicCategory ?? this.cicCategory,
          permitOverride: permitOverride ?? this.permitOverride,
          notes: notes ?? this.notes,
          SeeNote: SeeNote ?? this.SeeNote,
          customerName: customerName ?? this.customerName,
          countryId: countryId ?? this.countryId,
          regionName: regionName ?? this.regionName,
          website: website ?? this.website,
          billingAddress: billingAddress ?? this.billingAddress,
          officeId: officeId ?? this.officeId,
          bdm: bdm ?? this.bdm,
          bdmList: bdmList ?? this.bdmList,
          country: country ?? this.country,
          customerType: customerType ?? this.customerType,
          offices: offices ?? this.offices,
          teams: teams ?? this.teams);

  /// Deserializes the given [JsonMap] into a [CompanyProfile].
  static CompanyProfile fromJson(JsonMap json) =>
      _$CompanyProfileFromJson(json);

  /// Converts this [CompanyProfile] into a [JsonMap].
  JsonMap toJson() => _$CompanyProfileToJson(this);

  @override
  List<Object?> get props => [
        customerId,
        organizationId,
        accountingStatus,
        status,
        cicCategory,
        permitOverride,
        notes,
        SeeNote,
        customerName,
        countryId,
        regionName,
        website,
        billingAddress,
        officeId,
        bdm,
        bdmList,
        country,
        customerType,
        offices,
        teams
      ];
}
