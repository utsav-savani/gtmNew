import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'teams.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Teams extends Equatable {
  final int officeId;
  final String officeName;

  const Teams({
    required this.officeId,
    required this.officeName,
  });

  Teams copyWith({
    required int officeId,
    required String officeName,
  }) {
    return Teams(
      officeId: officeId,
      officeName: officeName,
    );
  }

  /// Deserializes the given [JsonMap] into a [Teams].
  static Teams fromJson(JsonMap json) => _$TeamsFromJson(json);

  /// Converts this [Teams] into a [JsonMap].
  JsonMap toJson() => _$TeamsToJson(this);

  @override
  List<Object?> get props => [officeId, officeName];
}
