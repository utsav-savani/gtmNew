import 'package:aircraft_repository/config/typedef_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable(explicitToJson: true)
class Country {
  final int countryId;
  final String name;
  final String? countryName;

  Country({required this.countryId, required this.name, this.countryName});
  static Country fromJson(JsonMap json) => _$CountryFromJson(json);

  /// Converts this [AircraftType] into a [JsonMap].
  JsonMap toJson() => _$CountryToJson(this);
}
