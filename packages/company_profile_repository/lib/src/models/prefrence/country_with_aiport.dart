import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:company_profile_repository/src/models/prefrence/prefrence_airport.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_with_aiport.g.dart';

@JsonSerializable(explicitToJson: true)
class CountryWithAirport {
  final int countryId;
  final String? id;
  final String name;
  final String? region;
  final List<PrefrenceAirport>? airports;

  CountryWithAirport(
      {required this.countryId,
      this.id,
      required this.name,
      this.region,
      this.airports});

  static CountryWithAirport fromJson(JsonMap json) =>
      _$CountryWithAirportFromJson(json);
  JsonMap toJson() => _$CountryWithAirportToJson(this);
}
