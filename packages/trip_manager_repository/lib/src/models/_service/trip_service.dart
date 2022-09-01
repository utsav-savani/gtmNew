import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';

part 'trip_service.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripService extends Equatable {
  final int? tripOverflyServiceId;
  final int? tripServiceId;
  final int? serviceId;
  final int? vendorId;
  final String? through;
  final String? serviceStatus;
  final String? scheduleStatus;
  final String? serviceCode;
  final String? service;
  final String? status;
  final bool? isRemovable;

  const TripService({
    this.tripOverflyServiceId,
    this.tripServiceId,
    this.serviceId,
    this.vendorId,
    this.through,
    this.serviceStatus,
    this.scheduleStatus,
    this.serviceCode,
    this.service,
    this.status,
    this.isRemovable,
  });

  TripService copyWith({
    int? tripOverflyServiceId,
    int? tripServiceId,
    int? serviceId,
    int? vendorId,
    String? through,
    String? serviceStatus,
    String? scheduleStatus,
    String? serviceCode,
    String? service,
    String? status,
    bool? isRemovable,
  }) {
    return TripService(
      tripOverflyServiceId: tripOverflyServiceId,
      tripServiceId: tripServiceId,
      serviceId: serviceId,
      vendorId: vendorId,
      through: through,
      serviceStatus: serviceStatus,
      scheduleStatus: scheduleStatus,
      serviceCode: serviceCode,
      service: service,
      status: status,
      isRemovable: isRemovable,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripService].
  static TripService fromJson(JsonMap json) => _$TripServiceFromJson(json);

  /// Converts this [TripService] into a [JsonMap].
  JsonMap toJson() => _$TripServiceToJson(this);

  @override
  List<Object?> get props => [
        tripOverflyServiceId,
        tripServiceId,
        serviceId,
        vendorId,
        through,
        serviceStatus,
        scheduleStatus,
        serviceCode,
        service,
        status,
        isRemovable,
      ];
}
