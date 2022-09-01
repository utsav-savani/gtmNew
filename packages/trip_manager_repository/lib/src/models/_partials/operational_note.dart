import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';
import 'package:trip_manager_repository/src/models/_partials/operational_service.dart';

part 'operational_note.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class OperationalNote extends Equatable {
  final String title;
  final List<OperationalService>? data;

  const OperationalNote({
    required this.title,
    this.data,
  });

  OperationalNote copyWith({
    required String title,
    List<OperationalService>? data,
  }) {
    return OperationalNote(
      title: title,
      data: data,
    );
  }

  /// Deserializes the given [JsonMap] into a [OperationalNote].
  static OperationalNote fromJson(JsonMap json) =>
      _$OperationalNoteFromJson(json);

  /// Converts this [OperationalNote] into a [JsonMap].
  JsonMap toJson() => _$OperationalNoteToJson(this);

  @override
  List<Object?> get props => [title, data];
}
