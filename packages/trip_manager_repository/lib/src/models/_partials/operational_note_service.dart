import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';

part 'operational_note_service.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class OperationalNoteService extends Equatable {
  final int? tripCustomerOperationalNoteId;
  final int? tripId;
  final String note;
  final String? category;
  final int? customerOperationalNoteId;
  final bool? archived;
  final String? creatorId;
  final String? editorId;
  final String? createdAt;
  final String? updatedAt;

  const OperationalNoteService({
    this.tripCustomerOperationalNoteId,
    this.tripId,
    required this.note,
    this.category,
    this.customerOperationalNoteId,
    this.archived,
    this.createdAt,
    this.updatedAt,
    this.creatorId,
    this.editorId,
  });

  OperationalNoteService copyWith({
    int? tripCustomerOperationalNoteId,
    int? tripId,
    required String note,
    String? category,
    int? customerOperationalNoteId,
    String? creatorId,
    String? editorId,
    bool? archived,
    String? createdAt,
    String? updatedAt,
  }) {
    return OperationalNoteService(
      tripCustomerOperationalNoteId: tripCustomerOperationalNoteId,
      note: note,
      tripId: tripId,
      archived: archived,
      category: category,
      createdAt: createdAt,
      creatorId: creatorId,
      customerOperationalNoteId: customerOperationalNoteId,
      editorId: editorId,
      updatedAt: updatedAt,
    );
  }

  /// Deserializes the given [JsonMap] into a [OperationalNoteService].
  static OperationalNoteService fromJson(JsonMap json) =>
      _$OperationalNoteServiceFromJson(json);

  /// Converts this [OperationalNoteService] into a [JsonMap].
  JsonMap toJson() => _$OperationalNoteServiceToJson(this);

  @override
  List<Object?> get props => [
        tripCustomerOperationalNoteId,
        note,
        tripId,
        archived,
        category,
        createdAt,
        creatorId,
        customerOperationalNoteId,
        editorId,
        updatedAt,
      ];
}
