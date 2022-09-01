import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:user_repository/src/config/typedef_json.dart';
import 'package:user_repository/src/model/models.dart';

part 'user_data.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)

/// User response returned as data
class UserDataObject extends Equatable {
  ///
  const UserDataObject(
      {required this.userId,
      this.emailAddress = '',
      this.isBDM = false,
      this.isInternal = '',
      this.firstName = '',
      this.lastName = '',
      this.timeZone = '',
      this.domainId = '',
      this.domainLogin = '',
      this.lastSignIn = '',
      this.description = '',
      this.jobtitle = '',
      this.department = '',
      this.streetaddress = '',
      this.city = '',
      this.zipcode = '',
      this.country = '',
      this.officephone = '',
      this.office = '',
      this.mobilephone = '',
      this.createdAt = '',
      this.updatedAt = '',
      this.status = false,
      this.offices = const [],
      this.customers = const []});

  /// status of the login
  final String userId;
  final String emailAddress;
  final bool status;
  final bool isBDM;
  final String isInternal;
  final String firstName;
  final String lastName;
  final String timeZone;
  final String domainId;
  final String domainLogin;
  final String lastSignIn;
  final String description;
  final String jobtitle;
  final String department;
  final String streetaddress;
  final String city;
  final String zipcode;
  final String country;
  final String officephone;
  final String office;
  final String mobilephone;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: 'Offices')
  final List<Office> offices;
  final List<Customer> customers;

  /// Empty UserDataObject which represents an unauthenticated UserDataObject.
  static const empty = UserDataObject(userId: '');

  /// Convenience getter to determine whether the current UserDataObject is empty.
  bool get isEmpty => this == UserDataObject.empty;

  /// Convenience getter to determine whether the current UserDataObject is not empty.
  bool get isNotEmpty => this != UserDataObject.empty;

  /// Deserializes the given [JsonMap] into a [UserDataObject].
  static UserDataObject fromJson(JsonMap json) => _$UserDataObjectFromJson(json);

  /// Converts this [UserData] into a [JsonMap].
  JsonMap toJson() => _$UserDataObjectToJson(this);

  @override
  List<Object?> get props => [];
}
