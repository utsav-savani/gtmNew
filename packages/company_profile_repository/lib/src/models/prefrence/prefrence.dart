import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:company_profile_repository/src/models/prefrence/country_with_aiport.dart';

import 'package:json_annotation/json_annotation.dart';

part 'prefrence.g.dart';

@JsonSerializable(explicitToJson: true)
class Prefrence {
  final String priority;
  final String? notes;
  final List<String>? servicesData;
  final List<String>? countryData;
  final List<String>? flightCategoryData;
  final List<String>? flightPurpusesData;
  final List<String>? equipmentsData;
  final List<CountryWithAirport>? countryWithAirport;

  Prefrence(
      {required this.priority,
      this.notes,
      this.servicesData,
      this.countryData,
      this.flightCategoryData,
      this.flightPurpusesData,
      this.equipmentsData,
      this.countryWithAirport});

  static Prefrence fromJson(JsonMap json) => _$PrefrenceFromJson(json);
  JsonMap toJson() => _$PrefrenceToJson(this);
}
