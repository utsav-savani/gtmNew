import 'package:flutter/material.dart';
import 'package:trip_manager_repository/src/models/_pob/trip_pob_office.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'trip_pob_schedule_main.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripPobScheduleMain extends Equatable {
  final List<TripPobSchedule> persons;
  final TripPobOffice tripOffice;

  TripPobScheduleMain({
    required this.persons,
    required this.tripOffice,
  });

  TripPobScheduleMain copyWith(
      {required List<TripPobSchedule> persons,
      required TripPobOffice tripOffice}) {
    return TripPobScheduleMain(persons: persons, tripOffice: tripOffice);
  }

  /// Deserializes the given [JsonMap] into a [TripPobScheduleMain].
  static TripPobScheduleMain fromJson(JsonMap json) =>
      _$TripPobScheduleMainFromJson(json);

  /// Converts this [TripPobScheduleMain] into a [JsonMap].
  JsonMap toJson() => _$TripPobScheduleMainToJson(this);

  @override
  List<Object?> get props => [persons, tripOffice];
}
