import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';

part 'airport_city.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class AirportCity extends Equatable {
  final int cityId;
  final String country;
  final String? city;

  const AirportCity({
    required this.cityId,
    required this.country,
    this.city,
  });

  AirportCity copyWith({
    required int cityId,
    required String country,
    String? city,
  }) {
    return AirportCity(
      cityId: cityId,
      country: country,
      city: city,
    );
  }

  /// Deserializes the given [JsonMap] into a [AirportCity].
  static AirportCity fromJson(JsonMap json) => _$AirportCityFromJson(json);

  /// Converts this [AirportCity] into a [JsonMap].
  JsonMap toJson() => _$AirportCityToJson(this);

  @override
  List<Object?> get props => [
        cityId,
        country,
        city,
      ];
}
