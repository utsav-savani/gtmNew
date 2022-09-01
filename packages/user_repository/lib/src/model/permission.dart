// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:user_repository/src/model/json_map.dart';

part 'permission.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Permission extends Equatable {
  final String roleId;
  final String permissionName;
  final String isView;
  final String isEdit;
  final String isAdd;
  final String isDelete;
  final String isOtherPermission;
  final String permissionLevel;

  const Permission({
    required this.roleId,
    required this.permissionName,
    required this.isView,
    required this.isEdit,
    required this.isAdd,
    required this.isDelete,
    required this.isOtherPermission,
    required this.permissionLevel,
  });

  Permission copyWith({
    required String roleId,
    required String permissionName,
    required String isView,
    required String isEdit,
    required String isAdd,
    required String isDelete,
    required String isOtherPermission,
    required String permissionLevel,
  }) {
    return Permission(
      roleId: roleId,
      permissionName: permissionName,
      isView: isView,
      isEdit: isEdit,
      isAdd: isAdd,
      isDelete: isDelete,
      isOtherPermission: isOtherPermission,
      permissionLevel: permissionLevel,
    );
  }

  /// Deserializes the given [JsonMap] into a [Permission].
  static Permission fromJson(JsonMap json) => _$PermissionFromJson(json);

  /// Converts this [Permission] into a [JsonMap].
  JsonMap toJson() => _$PermissionToJson(this);

  @override
  List<Object?> get props => [
        roleId,
        permissionName,
        isView,
        isEdit,
        isAdd,
        isDelete,
        isOtherPermission,
        permissionLevel
      ];
}
