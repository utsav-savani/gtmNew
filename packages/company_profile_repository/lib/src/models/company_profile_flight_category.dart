import 'package:company_profile_repository/src/models/flight_category.dart';
import 'package:country_repository/config/typedef_json.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company_profile_flight_category.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class CompanyProfileFlightCategory extends Equatable {
  final int flightCategoryId;
  final int customerId;
  @JsonKey(name: 'FlightCategory')
  final FlightCategory? flightCategory;
  final String? category;

  CompanyProfileFlightCategory({
    required this.flightCategoryId,
    required this.customerId,
    this.flightCategory,
    this.category,
  });

  CompanyProfileFlightCategory copyWith({
    required int flightCategoryId,
    required int customerId,
    FlightCategory? flightCategory,
    String? category,
  }) =>
      CompanyProfileFlightCategory(
        flightCategoryId: flightCategoryId,
        customerId: customerId,
        flightCategory: flightCategory ?? this.flightCategory,
        category: category ?? this.category,
      );

  /// Deserializes the given [JsonMap] into a [CompanyProfileFlightCategory].
  static CompanyProfileFlightCategory fromJson(JsonMap json) => _$CompanyProfileFlightCategoryFromJson(json);

  /// Converts this [CompanyProfileFlightCategory] into a [JsonMap].
  JsonMap toJson() => _$CompanyProfileFlightCategoryToJson(this);

  @override
  List<Object?> get props => [
        flightCategoryId,
        customerId,
        flightCategory,
        category,
      ];
}
