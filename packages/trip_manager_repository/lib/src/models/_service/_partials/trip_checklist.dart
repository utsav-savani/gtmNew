import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';

part 'trip_checklist.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripChecklist extends Equatable {
  final String? checkListsName;
  final String? checkListsNotes;

  const TripChecklist({
    this.checkListsName,
    this.checkListsNotes,
  });

  TripChecklist copyWith({
    String? checkListsName,
    String? checkListsNotes,
  }) {
    return TripChecklist(
      checkListsName: checkListsName,
      checkListsNotes: checkListsNotes,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripChecklist].
  static TripChecklist fromJson(JsonMap json) => _$TripChecklistFromJson(json);

  /// Converts this [TripChecklist] into a [JsonMap].
  JsonMap toJson() => _$TripChecklistToJson(this);

  @override
  List<Object?> get props => [checkListsName, checkListsNotes];
}
