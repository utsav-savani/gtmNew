// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:user_repository/src/model/json_map.dart';

part 'role.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Role extends Equatable {
  final String roleId;
  final String description;
  final String roleName;

  const Role({
    required this.roleId,
    required this.description,
    required this.roleName,
  });

  Role copyWith({
    required String roleId,
    required String description,
    required String roleName,
  }) {
    return Role(
      roleId: roleId,
      description: description,
      roleName: roleName,
    );
  }

  /// Deserializes the given [JsonMap] into a [Role].
  static Role fromJson(JsonMap json) => _$RoleFromJson(json);

  /// Converts this [Role] into a [JsonMap].
  JsonMap toJson() => _$RoleToJson(this);

  @override
  List<Object?> get props => [roleId, description, roleName];
}
