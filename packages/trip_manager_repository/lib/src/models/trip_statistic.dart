import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'trip_statistic.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripStatistic extends Equatable {
  final int total;
  final int completed;
  final int inProgress;
  final int draft;
  final int cancelled;


  const TripStatistic({
    required this.total,
    required this.completed,
    required this.inProgress,
    required this.draft,
    required this.cancelled,
  });

  TripStatistic copyWith({
    required int total,
    required int completed,
    required int inProgress,
    required int draft,
    required int cancelled,
  }) {
    return TripStatistic(
      total: total,
      completed: completed,
      inProgress: inProgress,
      draft: draft,
      cancelled: cancelled,
    );
  }

  /// Deserializes the given [JsonMap] into a [Trip].
  static TripStatistic fromJson(JsonMap json) => _$TripStatisticFromJson(json);

  /// Converts this [Trip] into a [JsonMap].
  JsonMap toJson() => _$TripStatisticToJson(this);

  @override
  List<Object?> get props => [
        total,
        completed,
        inProgress,
        draft,
        cancelled,
      ];
}
