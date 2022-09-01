import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';

part 'task_memo.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TaskMemo extends Equatable {
  final String? name;
  final String? date;
  final String? note;

  const TaskMemo({
    this.name,
    this.date,
    this.note,
  });

  TaskMemo copyWith({
    String? name,
    String? date,
    String? note,
  }) {
    return TaskMemo(
      name: name,
      date: date,
      note: note,
    );
  }

  /// Deserializes the given [JsonMap] into a [TaskMemo].
  static TaskMemo fromJson(JsonMap json) => _$TaskMemoFromJson(json);

  /// Converts this [TaskMemo] into a [JsonMap].
  JsonMap toJson() => _$TaskMemoToJson(this);

  @override
  List<Object?> get props => [name, date, note];
}
