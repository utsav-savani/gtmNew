import 'package:equatable/equatable.dart';
import 'package:flight_category_repository/config/typedef_json.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flight_category.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class FlightCategory extends Equatable {
  final int flightCategoryId;
  final String category;
  final int? customerId;

  const FlightCategory({
    required this.flightCategoryId,
    required this.category,
    this.customerId,
  });

  FlightCategory copyWith({
    required int flightCategoryId,
    int? customerId,
    required String category,
  }) {
    return FlightCategory(
      flightCategoryId: flightCategoryId,
      category: category,
      customerId: customerId,
    );
  }

  /// Deserializes the given [JsonMap] into a [FlightCategory].
  static FlightCategory fromJson(JsonMap json) =>
      _$FlightCategoryFromJson(json);

  /// Converts this [FlightCategory] into a [JsonMap].
  JsonMap toJson() => _$FlightCategoryToJson(this);

  @override
  List<Object?> get props => [flightCategoryId, category, customerId];
}
