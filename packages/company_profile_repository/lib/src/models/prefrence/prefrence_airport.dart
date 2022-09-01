import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'prefrence_airport.g.dart';

@JsonSerializable(explicitToJson: true)
class PrefrenceAirport {
  final int airportId;
  final String? id;
  final String name;
  final String? iata;
  final String? icao;

  PrefrenceAirport(
      {required this.airportId,
      required this.id,
      required this.name,
      this.iata,
      this.icao});

  static PrefrenceAirport fromJson(JsonMap json) =>
      _$PrefrenceAirportFromJson(json);
  JsonMap toJson() => _$PrefrenceAirportToJson(this);
}
