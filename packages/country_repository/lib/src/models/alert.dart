import 'package:country_repository/config/typedef_json.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'alert.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Alert extends Equatable {
  final int alertId;
  final String startDate;
  final String? endDate;
  final List<String>? category;
  final List<String>? type;

  const Alert({
    required this.alertId,
    required this.startDate,
    this.endDate,
    this.category,
    this.type,
  });

  Alert copyWith({
    required int alertId,
    required String startDate,
    required String? endDate,
    required List<String>? category,
    required List<String>? type,
  }) {
    return Alert(
      alertId: alertId,
      startDate: startDate,
      endDate: endDate,
      category: category,
      type: type,
    );
  }

  /// Deserializes the given [JsonMap] into a [Alert].
  static Alert fromJson(JsonMap json) => _$AlertFromJson(json);

  /// Converts this [Alert] into a [JsonMap].
  JsonMap toJson() => _$AlertToJson(this);

  @override
  List<Object?> get props => [
        alertId,
        startDate,
        endDate,
        category,
        type,
      ];
}
