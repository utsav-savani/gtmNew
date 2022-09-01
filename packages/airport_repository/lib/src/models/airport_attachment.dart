import 'package:equatable/equatable.dart';
import 'package:airport_repository/config/typedef_json.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'airport_attachment.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class AirportAttachment extends Equatable {
  final int? id;
  final int? airportId;
  final String? storedName;
  final String? name;

  const AirportAttachment({
    this.id,
    this.airportId,
    this.storedName,
    this.name,
  });

  AirportAttachment copyWith({
    int? id,
    int? airportId,
    String? storedName,
    String? name,
  }) {
    return AirportAttachment();
  }

  /// Deserializes the given [JsonMap] into a [AirportAttachment].
  static AirportAttachment fromJson(JsonMap json) => _$AirportAttachmentFromJson(json);

  /// Converts this [AirportAttachment] into a [JsonMap].
  JsonMap toJson() => _$AirportAttachmentToJson(this);

  @override
  List<Object?> get props => [
        id,
        airportId,
        storedName,
        name,
      ];
}
