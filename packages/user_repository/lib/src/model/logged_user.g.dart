// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logged_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoggedUser _$LoggedUserFromJson(Map<String, dynamic> json) => LoggedUser(
      data: User.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoggedUserToJson(LoggedUser instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };
