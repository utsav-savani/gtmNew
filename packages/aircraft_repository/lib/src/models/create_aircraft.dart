import 'package:aircraft_repository/config/typedef_json.dart';
import 'package:aircraft_repository/src/models/customers.dart';

import 'package:json_annotation/json_annotation.dart';

part 'create_aircraft.g.dart';

// had to create a different class because is some case name is coming null in response
@JsonSerializable(explicitToJson: true)
class CreateAircraft {
  int? aircraftId;
  final int aircraftTypeId;
  final int? baseAirportId;
  final int regCountryId;
  final bool? isCloneData;
  final bool? iscreatedByCustomer;
  final String registrationNumber;
  final int seatCap;
  final int category;
  final String noiseCategory;
  final String? serialNumber;
  final int mtow;
  final String defaultUnit;
  final String mtowUnit;
  final String iata;
  final String icao;
  final int? runwayFt;
  final String referenceCode;
  final String? remark;
  @JsonKey(name: 'customers')
  final List<int>? customerIds;
  @JsonKey(name: 'operatorId')
  final List<int>? operatorIds;
  final bool archived;
  @JsonKey(name: 'Customers')
  final List<Customers>? customerDetails;
  @JsonKey(name: 'Operators')
  final List<Customers>? operatorDetails;

  CreateAircraft(
      {this.aircraftId,
      required this.aircraftTypeId,
      this.baseAirportId,
      required this.regCountryId,
      this.isCloneData = false,
      this.iscreatedByCustomer = false,
      required this.registrationNumber,
      required this.seatCap,
      required this.category,
      required this.noiseCategory,
      this.serialNumber,
      required this.mtow,
      required this.defaultUnit,
      required this.mtowUnit,
      required this.iata,
      required this.icao,
      this.runwayFt,
      required this.referenceCode,
      this.remark,
      this.customerIds,
      this.operatorIds,
      this.customerDetails,
      this.operatorDetails,
      this.archived = false});

  static CreateAircraft fromJson(JsonMap json) =>
      _$CreateAircraftFromJson(json);

  JsonMap toJson() {
    var temp = {
      'aircraftTypeId': this.aircraftTypeId,
      'baseAirportId': this.baseAirportId,
      'regCountryId': this.regCountryId,
      'isCloneData': this.isCloneData,
      'iscreatedByCustomer': this.iscreatedByCustomer,
      'registrationNumber': this.registrationNumber,
      'seatCap': this.seatCap,
      'category': this.category,
      'noiseCategory': this.noiseCategory,
      'serialNumber': this.serialNumber,
      'mtow': this.mtow,
      'defaultUnit': this.defaultUnit,
      'mtowUnit': this.mtowUnit,
      'iata': this.iata,
      'icao': this.icao,
      'runwayFt': this.runwayFt,
      'referenceCode': this.referenceCode,
      'remark': this.remark,
      'customers': this.customerIds,
      'operatorId': this.operatorIds,
      'archived': this.archived,
      'Customers': this.customerDetails?.map((e) => e.toJson()).toList(),
      'Operators': this.operatorDetails?.map((e) => e.toJson()).toList(),
    };
    if (this.aircraftId != null) {
      temp.putIfAbsent('aircraftId', () => this.aircraftId);
    }
    return temp;
  }
}
