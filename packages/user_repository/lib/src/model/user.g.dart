// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userId: json['userId'] as String,
      emailAddress: json['emailAddress'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      lastSignIn: json['lastSignIn'] as String? ?? '',
      token: json['token'] as String? ?? '',
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'emailAddress': instance.emailAddress,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'lastSignIn': instance.lastSignIn,
      'token': instance.token,
    };
