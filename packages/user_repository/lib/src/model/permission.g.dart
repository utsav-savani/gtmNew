// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Permission _$PermissionFromJson(Map<String, dynamic> json) => Permission(
      roleId: json['roleId'] as String,
      permissionName: json['permissionName'] as String,
      isView: json['isView'] as String,
      isEdit: json['isEdit'] as String,
      isAdd: json['isAdd'] as String,
      isDelete: json['isDelete'] as String,
      isOtherPermission: json['isOtherPermission'] as String,
      permissionLevel: json['permissionLevel'] as String,
    );

Map<String, dynamic> _$PermissionToJson(Permission instance) =>
    <String, dynamic>{
      'roleId': instance.roleId,
      'permissionName': instance.permissionName,
      'isView': instance.isView,
      'isEdit': instance.isEdit,
      'isAdd': instance.isAdd,
      'isDelete': instance.isDelete,
      'isOtherPermission': instance.isOtherPermission,
      'permissionLevel': instance.permissionLevel,
    };
