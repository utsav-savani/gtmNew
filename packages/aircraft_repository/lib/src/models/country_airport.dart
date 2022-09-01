import 'package:aircraft_repository/config/typedef_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_airport.g.dart';

@JsonSerializable(explicitToJson: true)
class CountryAirport {
  final int airportId;
  final String? city;
  final int? countryId;
  final String? countryName;
  final String? iata;
  final String? icao;
  final String? fullName;
  final String? name;

  CountryAirport(
      {required this.airportId,
      this.city,
      this.countryId,
      this.countryName,
      this.iata,
      this.icao,
      this.fullName,
      this.name});

  static CountryAirport fromJson(JsonMap json) =>
      _$CountryAirportFromJson(json);

  JsonMap toJson() => _$CountryAirportToJson(this);
}
