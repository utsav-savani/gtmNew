import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';

part 'sequence_schedule.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class SequenceSchedule extends Equatable {
  final String? type;
  final String? icoa;
  final String? date;
  final String? timezone;

  const SequenceSchedule({
    this.type,
    this.icoa,
    this.date,
    this.timezone,
  });

  SequenceSchedule copyWith({
    String? type,
    String? icoa,
    String? date,
    String? timezone,
  }) {
    return SequenceSchedule(
      type: type,
      icoa: icoa,
      date: date,
      timezone: timezone,
    );
  }

  /// Deserializes the given [JsonMap] into a [SequenceSchedule].
  static SequenceSchedule fromJson(JsonMap json) =>
      _$SequenceScheduleFromJson(json);

  /// Converts this [SequenceSchedule] into a [JsonMap].
  JsonMap toJson() => _$SequenceScheduleToJson(this);

  @override
  List<Object?> get props => [type, icoa, date, timezone];
}
