import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:operator_repository/config/typedef_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Organization extends Equatable {
  final String name;

  const Organization({required this.name});

  Organization copyWith({required String name}) {
    return Organization(name: name);
  }

  /// Deserializes the given [JsonMap] into a [Organization].
  static Organization fromJson(JsonMap json) => _$OrganizationFromJson(json);

  /// Converts this [Organization] into a [JsonMap].
  JsonMap toJson() => _$OrganizationToJson(this);
  @override
  List<Object?> get props => [name];
}
