import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/src/config/typedef_json.dart';

part 'auth_user.g.dart';

/// auth user model
///
@immutable
@JsonSerializable(explicitToJson: true)
class AuthUser extends Equatable {
  /// {user class for basic test}
  const AuthUser({
    required this.userId,
    this.emailAddress = '',
    this.status = false,
    this.isBDM = false,
    this.isInternal = false,
    this.firstName = '',
    this.lastName = '',
    this.timeZone = '',
    this.domainId = '',
    this.domainLogin = '',
    this.lastSignIn,
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
    this.createdAt,
    this.updatedAt,
  });

  final String userId;
  final String emailAddress;
  final bool status;
  final bool isBDM;
  final bool isInternal;
  final String firstName;
  final String lastName;
  final String timeZone;
  final String domainId;
  final String domainLogin;
  final DateTime? lastSignIn;
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
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ///  return a copy of this Object with the given values updated
  AuthUser copyWith({
    String? userId,
    String? emailAddress,
    bool? status,
    bool? isBDM,
    bool? isInternal,
    String? firstName,
    String? lastName,
    String? timeZone,
    String? domainId,
    String? domainLogin,
    DateTime? lastSignIn,
    String? description,
    String? jobtitle,
    String? department,
    String? streetaddress,
    String? city,
    String? zipcode,
    String? country,
    String? officephone,
    String? office,
    String? mobilephone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AuthUser(
      userId: userId ?? this.userId,
      emailAddress: emailAddress ?? this.emailAddress,
      status: status ?? this.status,
      isBDM: isBDM ?? this.isBDM,
      isInternal: isInternal ?? this.isInternal,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      timeZone: timeZone ?? this.timeZone,
      domainId: domainId ?? this.domainId,
      domainLogin: domainLogin ?? this.domainLogin,
      lastSignIn: lastSignIn ?? this.lastSignIn,
      description: description ?? this.description,
      jobtitle: jobtitle ?? this.jobtitle,
      department: department ?? this.department,
      streetaddress: streetaddress ?? this.streetaddress,
      city: city ?? this.city,
      zipcode: zipcode ?? this.zipcode,
      country: country ?? this.country,
      officephone: officephone ?? this.officephone,
      office: office ?? this.office,
      mobilephone: mobilephone ?? this.mobilephone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Deserializes the given [JsonMap] into a [AuthUser].
  static AuthUser fromJson(JsonMap json) => _$AuthUserFromJson(json);

  /// Converts this [AuthUser] into a [JsonMap].
  JsonMap toJson() => _$AuthUserToJson(this);

  /// Empty user which represents an unauthenticated user.
  static const empty = AuthUser(userId: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == AuthUser.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != AuthUser.empty;
  @override
  List<Object> get props => [
        userId,
        emailAddress,
        mobilephone,
      ];
}
