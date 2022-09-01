import 'package:flutter/material.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'trip_document_filter_model.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripDocumentFilterModel extends Equatable {
  final int tripId;
  final List<TripDocumentSchedule> tripScedule;
  final List<TripDocumentService> services;


  const TripDocumentFilterModel({
    required this.tripId,
    required this.tripScedule,
    required this.services,
  });

  TripDocumentFilterModel copyWith({
    required int tripId,
    required List<TripDocumentSchedule> tripScedule,
    required List<TripDocumentService> services,
    String? fileName,
  }) {
    return TripDocumentFilterModel(
      tripId: tripId,
      tripScedule: tripScedule,
      services: services,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripDocumentFilterModel].
  static TripDocumentFilterModel fromJson(JsonMap json) =>
      _$TripDocumentFilterModelFromJson(json);

  /// Converts this [TripDocumentFilterModel] into a [JsonMap].
  JsonMap toJson() => _$TripDocumentFilterModelToJson(this);

  @override
  List<Object?> get props => [
        tripId,
        tripScedule,
        services,
      ];
}
