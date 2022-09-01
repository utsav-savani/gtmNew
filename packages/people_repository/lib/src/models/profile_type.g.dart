// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileType _$ProfileTypeFromJson(Map<String, dynamic> json) => ProfileType(
      formId: json['formId'] as int,
    )
      ..isCaptain = json['isCaptain'] as bool
      ..isCrew = json['isCrew'] as bool
      ..isOther = json['isOther'] as bool
      ..isPassenger = json['isPassenger'] as bool
      ..isVip = json['isVip'] as bool;

Map<String, dynamic> _$ProfileTypeToJson(ProfileType instance) =>
    <String, dynamic>{
      'formId': instance.formId,
      'isCaptain': instance.isCaptain,
      'isCrew': instance.isCrew,
      'isOther': instance.isOther,
      'isPassenger': instance.isPassenger,
      'isVip': instance.isVip,
    };
