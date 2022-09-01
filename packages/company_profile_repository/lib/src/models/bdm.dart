import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bdm.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Bdm extends Equatable {
  final String? userId;
  final String? name;

  Bdm({this.userId, this.name});

  /// Deserializes the given [JsonMap] into a [Bdm].
  static Bdm fromJson(JsonMap json) => _$BdmFromJson(json);

  /// Converts this [Bdm] into a [JsonMap].
  JsonMap toJson() => _$BdmToJson(this);

  @override
  List<Object?> get props => [userId, name];
}
