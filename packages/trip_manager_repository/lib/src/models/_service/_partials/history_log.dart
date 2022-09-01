import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';

part 'history_log.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class HistoryLog extends Equatable {
  final String? date;
  final String? description;

  const HistoryLog({
    this.date,
    this.description,
  });

  HistoryLog copyWith({
    String? date,
    String? description,
  }) {
    return HistoryLog(
      date: date,
      description: description,
    );
  }

  /// Deserializes the given [JsonMap] into a [HistoryLog].
  static HistoryLog fromJson(JsonMap json) => _$HistoryLogFromJson(json);

  /// Converts this [HistoryLog] into a [JsonMap].
  JsonMap toJson() => _$HistoryLogToJson(this);

  @override
  List<Object?> get props => [date, description];
}
