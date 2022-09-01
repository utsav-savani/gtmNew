import 'package:flutter/material.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'trip_document_schedule.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripDocumentSchedule extends Equatable {
  final int tripsequenceNumber;
  final int tripScheduleId;
  final String name;

  const TripDocumentSchedule({
    required this.tripsequenceNumber,
    required this.tripScheduleId,
    required this.name,
  });

  TripDocumentSchedule copyWith({
    required int tripsequenceNumber,
    required int tripScheduleId,
    required String name,
    String? fileName,
  }) {
    return TripDocumentSchedule(
      tripsequenceNumber: tripsequenceNumber,
      tripScheduleId: tripScheduleId,
      name: name,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripDocumentSchedule].
  static TripDocumentSchedule fromJson(JsonMap json) =>
      _$TripDocumentScheduleFromJson(json);

  /// Converts this [TripDocumentSchedule] into a [JsonMap].
  JsonMap toJson() => _$TripDocumentScheduleToJson(this);

  @override
  List<Object?> get props => [
        tripsequenceNumber,
        tripScheduleId,
        name,
      ];
}
