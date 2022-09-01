import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

/// User for test api
@immutable
@JsonSerializable()
class User extends Equatable {
  /// {user class for basic test}
  User({
    this.token = '',
    required this.userId,
    this.emailAddress = '',
    String? firstName,
    this.lastName = '',
    this.mobilephone = '',
    this.timeZone = '',
    this.createdAt = '',
  })  : assert(
          firstName == null || firstName.isNotEmpty,
          'id can not be null and should be empty',
        ),
        firstName = firstName ?? 'Test';

  /// basic token of user we get from the server api
  final String token;

  /// user id from the api
  final String userId;

  /// user email address from the api
  final String emailAddress;

  /// user firstname from the api
  final String firstName;

  /// user lastname form the api
  final String lastName;

  /// user mobile phone from the api
  final String mobilephone;

  /// user timezone
  final String timeZone;

  /// user created
  final String createdAt;

  ///  return a copy of this Object with the given values updated
  User copyWith({
    String? token,
    String? userId,
    String? emailAddress,
    String? firstName,
    String? lastName,
    String? mobilephone,
    String? timeZone,
    String? createdAt,
  }) {
    return User(
      token: token ?? this.token,
      userId: userId ?? this.userId,
      emailAddress: emailAddress ?? this.emailAddress,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      mobilephone: mobilephone ?? this.mobilephone,
      timeZone: timeZone ?? this.timeZone,
      createdAt: createdAt ?? this.createdAt,
    );
  }
/* 
  /// Deserializes the given [JsonMap] into a [User].
  static User fromJson(JsonMap json) => _$UserFromJson(json);

  /// Converts this [User] into a [JsonMap].
  JsonMap toJson() => _$UserToJson(this); */

  @override
  List<Object> get props => [
        userId,
        emailAddress,
        mobilephone,
      ];
}
