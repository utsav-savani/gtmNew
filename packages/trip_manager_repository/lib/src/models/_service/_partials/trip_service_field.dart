import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';

part 'trip_service_field.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripServiceField extends Equatable {
  final String? text;
  final String? value;

  const TripServiceField({
    this.text,
    this.value,
  });

  TripServiceField copyWith({
    String? text,
    String? value,
  }) {
    return TripServiceField(
      text: text,
      value: value,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripServiceField].
  static TripServiceField fromJson(JsonMap json) =>
      _$TripServiceFieldFromJson(json);

  /// Converts this [TripServiceField] into a [JsonMap].
  JsonMap toJson() => _$TripServiceFieldToJson(this);

  @override
  List<Object?> get props => [text, value];
}
