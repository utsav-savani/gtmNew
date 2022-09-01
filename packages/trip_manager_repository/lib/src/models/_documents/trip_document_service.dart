import 'package:flutter/material.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'trip_document_service.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripDocumentService extends Equatable {
  final int serviceId;
  final String service;

  const TripDocumentService({
    required this.serviceId,
    required this.service,
  });

  TripDocumentService copyWith({
    required int serviceId,
    required String service,
  }) {
    return TripDocumentService(
      serviceId: serviceId,
      service: service,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripDocumentService].
  static TripDocumentService fromJson(JsonMap json) =>
      _$TripDocumentServiceFromJson(json);

  /// Converts this [TripDocumentService] into a [JsonMap].
  JsonMap toJson() => _$TripDocumentServiceToJson(this);

  @override
  List<Object?> get props => [
        serviceId,
        service,
      ];
}
