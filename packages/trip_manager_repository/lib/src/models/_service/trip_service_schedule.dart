import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';
import 'package:trip_manager_repository/src/models/_service/mandatory_service.dart';
import 'package:trip_manager_repository/src/models/_service/trip_service.dart';

part 'trip_service_schedule.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripServiceSchedule extends Equatable {
  final int? tripScheduleId;
  final int? airportId;
  final int? countryId;
  final int? flightCategoryId;
  @JsonKey(name: 'ETA')
  final String? eTA;
  @JsonKey(name: 'ETD')
  final String? eTD;
  @JsonKey(name: 'ETATBA')
  final bool? eTATBA;
  @JsonKey(name: 'ETDTBA')
  final bool? eTDTBA;
  final String? name;
  final String? timezone;
  final bool? isOverFlight;
  final int? tripOverflyId;
  final List<TripService>? services;
  final List<MandatoryService>? mandatoryServicesList;

  TripServiceSchedule({
    this.eTA,
    this.eTATBA,
    this.eTD,
    this.eTDTBA,
    this.isOverFlight,
    this.tripOverflyId,
    this.name,
    this.timezone,
    this.tripScheduleId,
    this.airportId,
    this.flightCategoryId,
    this.services,
    this.countryId,
    this.mandatoryServicesList,
  });

  TripServiceSchedule copyWith({
    int? tripScheduleId,
    int? airportId,
    int? countryId,
    int? flightCategoryId,
    String? eTA,
    String? eTD,
    bool? eTATBA,
    bool? eTDTBA,
    String? name,
    String? timezone,
    bool? isOverFlight,
    int? tripOverflyId,
    List<TripService>? services,
    List<MandatoryService>? mandatoryServicesList,
  }) {
    return TripServiceSchedule(
      tripScheduleId: tripScheduleId ?? this.tripScheduleId,
      airportId: airportId ?? this.airportId,
      countryId: countryId ?? this.countryId,
      flightCategoryId: flightCategoryId ?? this.flightCategoryId,
      eTA: eTA ?? this.eTA,
      eTD: eTD ?? this.eTD,
      eTATBA: eTATBA ?? this.eTATBA,
      eTDTBA: eTDTBA ?? this.eTDTBA,
      name: name ?? this.name,
      timezone: timezone ?? this.timezone,
      tripOverflyId: tripOverflyId ?? this.tripOverflyId,
      isOverFlight: isOverFlight ?? this.isOverFlight,
      services: services ?? this.services,
      mandatoryServicesList:
          mandatoryServicesList ?? this.mandatoryServicesList,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripServiceSchedule].
  static TripServiceSchedule fromJson(JsonMap json) =>
      _$TripServiceScheduleFromJson(json);

  /// Converts this [TripServiceSchedule] into a [JsonMap].
  JsonMap toJson() => _$TripServiceScheduleToJson(this);

  @override
  List<Object?> get props => [
        tripScheduleId,
        airportId,
        countryId,
        flightCategoryId,
        eTA,
        eTD,
        eTATBA,
        eTDTBA,
        name,
        timezone,
        tripOverflyId,
        isOverFlight,
        services,
        mandatoryServicesList,
      ];
}
