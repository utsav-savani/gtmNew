import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';

part 'mandatory_service.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class MandatoryService extends Equatable {
  final int? serviceId;
  final String? service;
  final int? serviceCategoryId;

  const MandatoryService({
    this.serviceId,
    this.service,
    this.serviceCategoryId,
  });

  MandatoryService copyWith({
    int? serviceId,
    String? service,
    int? serviceCategoryId,
  }) {
    return MandatoryService(
      serviceId: serviceId,
      service: service,
      serviceCategoryId: serviceCategoryId,
    );
  }

  /// Deserializes the given [JsonMap] into a [MandatoryService].
  static MandatoryService fromJson(JsonMap json) =>
      _$MandatoryServiceFromJson(json);

  /// Converts this [MandatoryService] into a [JsonMap].
  JsonMap toJson() => _$MandatoryServiceToJson(this);

  @override
  List<Object?> get props => [serviceId, service, serviceCategoryId];
}
