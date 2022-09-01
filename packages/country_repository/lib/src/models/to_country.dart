import 'package:country_repository/config/typedef_json.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'to_country.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class ToCountry extends Equatable {
  final int countryId;
  final String name;
  final String code3;

  const ToCountry({
    required this.countryId,
    required this.name,
    required this.code3,
  });

  ToCountry copyWith({
    required int countryId,
    required String name,
    required String code3,
  }) {
    return ToCountry(
      countryId: countryId,
      name: name,
      code3: code3,
    );
  }

  /// Deserializes the given [JsonMap] into a [ToCountry].
  static ToCountry fromJson(JsonMap json) => _$ToCountryFromJson(json);

  /// Converts this [ToCountry] into a [JsonMap].
  JsonMap toJson() => _$ToCountryToJson(this);

  @override
  List<Object?> get props => [countryId, name, code3];
}
