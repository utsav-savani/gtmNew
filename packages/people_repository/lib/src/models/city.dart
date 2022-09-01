import 'package:json_annotation/json_annotation.dart';
import 'package:people_repository/config/typedef_json.dart';

part 'city.g.dart';

@JsonSerializable(explicitToJson: true)
class City {
  final int cityId;
  final String city;
  final String country;

  City(this.cityId, this.city, this.country);

  static City fromJson(JsonMap json) => _$CityFromJson(json);
  JsonMap toJson() => _$CityToJson(this);
}
