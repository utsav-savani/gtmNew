import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';

part 'trip_schedule_overflight.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripScheduleOverflight extends Equatable {
  final int? tripOverflyId;
  final String overflyCountry;
  @JsonKey(name: 'EntryPoint')
  final String entryPoint;
  @JsonKey(name: 'ExitPoint')
  final String exitPoint;
  final String code;
  final int sequenceNum;

  const TripScheduleOverflight({
    this.tripOverflyId,
    required this.overflyCountry,
    required this.entryPoint,
    required this.exitPoint,
    required this.code,
    required this.sequenceNum,
  });

  TripScheduleOverflight copyWith({
    int? tripOverflyId,
    required String overflyCountry,
    required String entryPoint,
    required String exitPoint,
    required String code,
    required int sequenceNum,
  }) {
    return TripScheduleOverflight(
      tripOverflyId: tripOverflyId,
      code: code,
      entryPoint: entryPoint,
      exitPoint: exitPoint,
      overflyCountry: overflyCountry,
      sequenceNum: sequenceNum,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripSchedule].
  static TripScheduleOverflight fromJson(JsonMap json) =>
      _$TripScheduleOverflightFromJson(json);

  /// Converts this [TripScheduleOverflight] into a [JsonMap].
  JsonMap toJson() => _$TripScheduleOverflightToJson(this);

  @override
  List<Object?> get props => [
        tripOverflyId,
        code,
        entryPoint,
        exitPoint,
        overflyCountry,
        sequenceNum,
      ];
}
