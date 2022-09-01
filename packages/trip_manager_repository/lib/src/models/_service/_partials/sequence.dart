import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';
import 'package:trip_manager_repository/src/models/_service/_partials/sequence_schedule.dart';

part 'sequence.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Sequence extends Equatable {
  final String? name;
  final bool? isUTC;
  final List<SequenceSchedule>? schedules;

  const Sequence({
    this.name,
    this.isUTC,
    this.schedules,
  });

  Sequence copyWith({
    String? name,
    bool? isUTC,
    List<SequenceSchedule>? schedules,
  }) {
    return Sequence(
      name: name,
      isUTC: isUTC,
      schedules: schedules,
    );
  }

  /// Deserializes the given [JsonMap] into a [Sequence].
  static Sequence fromJson(JsonMap json) => _$SequenceFromJson(json);

  /// Converts this [Sequence] into a [JsonMap].
  JsonMap toJson() => _$SequenceToJson(this);

  @override
  List<Object?> get props => [name, isUTC, schedules];
}
