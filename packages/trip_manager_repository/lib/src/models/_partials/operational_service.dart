import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';
import 'package:trip_manager_repository/src/models/_partials/operational_note_service.dart';

part 'operational_service.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class OperationalService extends Equatable {
  final int? serviceId;
  final int? serviceCategoryId;
  final String? service;
  final List<OperationalNoteService>? notes;

  const OperationalService({
    this.serviceId,
    this.serviceCategoryId,
    this.service,
    this.notes,
  });

  OperationalService copyWith({
    int? serviceId,
    int? serviceCategoryId,
    String? service,
    List<OperationalNoteService>? notes,
  }) {
    return OperationalService(
      serviceId: serviceId,
      serviceCategoryId: serviceCategoryId,
      service: service,
      notes: notes,
    );
  }

  /// Deserializes the given [JsonMap] into a [OperationalService].
  static OperationalService fromJson(JsonMap json) =>
      _$OperationalServiceFromJson(json);

  /// Converts this [OperationalService] into a [JsonMap].
  JsonMap toJson() => _$OperationalServiceToJson(this);

  @override
  List<Object?> get props => [
        serviceId,
        serviceCategoryId,
        service,
        notes,
      ];
}
