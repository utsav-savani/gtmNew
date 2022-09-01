import 'package:airport_repository/config/typedef_json.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'airport_city.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class AirportCity {
  final int? cityId;
  final String? city;
  final String? country;

  const AirportCity({this.cityId, this.country, this.city});

  /// Deserializes the given [JsonMap] into a [Airport].
  static AirportCity fromJson(JsonMap json) => _$AirportCityFromJson(json);

  /// Converts this [AirportCity] into a [JsonMap].
  JsonMap toJson() => _$AirportCityToJson(this);

  List<Object?> get props => [city, cityId, country];
}
