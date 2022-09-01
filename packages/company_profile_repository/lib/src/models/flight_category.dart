import 'package:equatable/equatable.dart';
import 'package:country_repository/config/typedef_json.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'flight_category.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class FlightCategory extends Equatable {
  final String? category;
  final int? flightCategoryId;

  FlightCategory({this.category, this.flightCategoryId});

  FlightCategory copyWith({
    String? category,
    int? flightCategoryId,
  }) =>
      FlightCategory(
        category: category ?? this.category,
        flightCategoryId: flightCategoryId ?? this.flightCategoryId,
      );

  /// Deserializes the given [JsonMap] into a [FlightCategory].
  static FlightCategory fromJson(JsonMap json) => _$FlightCategoryFromJson(json);

  /// Converts this [FlightCategory] into a [JsonMap].
  JsonMap toJson() => _$FlightCategoryToJson(this);

  @override
  List<Object?> get props => [category, flightCategoryId];
}
