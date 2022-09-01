import 'package:flutter/material.dart';
import 'package:trip_manager_repository/src/models.dart';
import 'package:trip_manager_repository/src/models/_service/mandatory_service.dart';
import 'package:trip_manager_repository/src/models/_service/trip_service.dart';

part 'trip_service_main.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripServiceMain extends Equatable {
  // Since Equatable does not know how to check equality for lists, we are using a string variable to differ the previous state object so bloc can emit the new object
  final String? objectEqualityChecker;
  final List<TripService>? services;
  final List<TripServiceSchedule>? schedule;
  final List<MandatoryService>? mondatoryServices;

  const TripServiceMain({
    this.objectEqualityChecker,
    this.services,
    this.schedule,
    this.mondatoryServices,
  });

  TripServiceMain copyWith({
    String? objectEqualityChecker,
    List<TripService>? services,
    List<TripServiceSchedule>? schedule,
    List<MandatoryService>? mondatoryServices,
  }) {
    return TripServiceMain(
      objectEqualityChecker: objectEqualityChecker,
      services: services,
      schedule: schedule,
      mondatoryServices: mondatoryServices,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripServiceMain].
  static TripServiceMain fromJson(JsonMap json) =>
      _$TripServiceMainFromJson(json);

  /// Converts this [TripServiceMain] into a [JsonMap].
  JsonMap toJson() => _$TripServiceMainToJson(this);

  @override
  List<Object?> get props =>
      [services, schedule, mondatoryServices, objectEqualityChecker];
}
