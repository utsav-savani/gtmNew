import 'package:flutter/material.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'passport_country.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class PassportCountry extends Equatable {
  final int? countryId;
  final String? name;
  final String? code;
  final String? code3;

  const PassportCountry({
    this.countryId,
    this.name,
    this.code,
    this.code3,
  });

  PassportCountry copyWith({
    int? countryId,
    String? name,
    String? code,
    String? code3,
  }) {
    return PassportCountry(
      countryId: countryId,
      name: name,
      code: code,
      code3: code3,
    );
  }

  /// Deserializes the given [JsonMap] into a [PassportCountry].
  static PassportCountry fromJson(JsonMap json) =>
      _$PassportCountryFromJson(json);

  /// Converts this [PassportCountry] into a [JsonMap].
  JsonMap toJson() => _$PassportCountryToJson(this);

  @override
  List<Object?> get props => [
        countryId,
        name,
        code,
        code3,
      ];
}
