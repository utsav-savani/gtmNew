import 'package:aircraft_repository/config/typedef_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_airport.g.dart';

@JsonSerializable(explicitToJson: true)
class BaseAirport {
  final int airportId;
  final String name;
  final String? iata;
  final String? icao;

  BaseAirport(this.airportId, this.name, this.iata, this.icao);
  static BaseAirport fromJson(JsonMap json) => _$BaseAirportFromJson(json);

  /// Converts this [AircraftType] into a [JsonMap].
  JsonMap toJson() => _$BaseAirportToJson(this);
}
