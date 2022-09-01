import 'package:aircraft_repository/config/typedef_json.dart';
import 'package:aircraft_repository/src/models/aircraft_type.dart';
import 'package:aircraft_repository/src/models/base_airport.dart';
import 'package:aircraft_repository/src/models/country.dart';
import 'package:aircraft_repository/src/models/customers.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aircraft_details.g.dart';

@JsonSerializable(explicitToJson: true)
class AircraftDetails {
  final int aircraftId;
  final String? registrationNumber;
  @JsonKey(name: 'AircraftType')
  final AircraftType? aircraftType;
  final int? regCountryId;
  @JsonKey(name: 'Customers')
  final List<Customers> customers;
  @JsonKey(name: 'BaseAirport')
  final BaseAirport? baseAirport;
  final String icao;
  final String? noiseCategory;
  final int? runwayFt;
  final int? category;
  final String? referenceCode;
  final String? remark;
  @JsonKey(name: 'Operators')
  final List<Customers>? operators;
  @JsonKey(name: 'Country')
  final Country? country;
  final int? seatCap;
  final String? iata;
  final double? mtow;
  final String? mtowUnit;

  AircraftDetails(
      this.aircraftId,
      this.registrationNumber,
      this.aircraftType,
      this.regCountryId,
      this.customers,
      this.baseAirport,
      this.icao,
      this.noiseCategory,
      this.category,
      this.runwayFt,
      this.referenceCode,
      this.remark,
      this.operators,
      this.country,
      this.seatCap,
      this.iata,
      this.mtow,
      this.mtowUnit);
  static AircraftDetails fromJson(JsonMap json) =>
      _$AircraftDetailsFromJson(json);

  /// Converts this [AircraftDetails] into a [JsonMap].
  JsonMap toJson() => _$AircraftDetailsToJson(this);
}
