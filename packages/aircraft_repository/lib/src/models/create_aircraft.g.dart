// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_aircraft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAircraft _$CreateAircraftFromJson(Map<String, dynamic> json) =>
    CreateAircraft(
      aircraftId: json['aircraftId'] as int?,
      aircraftTypeId: json['aircraftTypeId'] as int,
      baseAirportId: json['baseAirportId'] as int?,
      regCountryId: json['regCountryId'] as int,
      isCloneData: json['isCloneData'] as bool? ?? false,
      iscreatedByCustomer: json['iscreatedByCustomer'] as bool? ?? false,
      registrationNumber: json['registrationNumber'] as String,
      seatCap: json['seatCap'] as int,
      category: json['category'] as int,
      noiseCategory: json['noiseCategory'] as String,
      serialNumber: json['serialNumber'] as String?,
      mtow: json['mtow'] as int,
      defaultUnit: json['defaultUnit'] as String,
      mtowUnit: json['mtowUnit'] as String,
      iata: json['iata'] as String,
      icao: json['icao'] as String,
      runwayFt: json['runwayFt'] as int?,
      referenceCode: json['referenceCode'] as String,
      remark: json['remark'] as String?,
      customerIds:
          (json['customers'] as List<dynamic>?)?.map((e) => e as int).toList(),
      operatorIds:
          (json['operatorId'] as List<dynamic>?)?.map((e) => e as int).toList(),
      customerDetails: (json['Customers'] as List<dynamic>?)
          ?.map((e) => Customers.fromJson(e as Map<String, dynamic>))
          .toList(),
      operatorDetails: (json['Operators'] as List<dynamic>?)
          ?.map((e) => Customers.fromJson(e as Map<String, dynamic>))
          .toList(),
      archived: json['archived'] as bool? ?? false,
    );

Map<String, dynamic> _$CreateAircraftToJson(CreateAircraft instance) =>
    <String, dynamic>{
      'aircraftId': instance.aircraftId,
      'aircraftTypeId': instance.aircraftTypeId,
      'baseAirportId': instance.baseAirportId,
      'regCountryId': instance.regCountryId,
      'isCloneData': instance.isCloneData,
      'iscreatedByCustomer': instance.iscreatedByCustomer,
      'registrationNumber': instance.registrationNumber,
      'seatCap': instance.seatCap,
      'category': instance.category,
      'noiseCategory': instance.noiseCategory,
      'serialNumber': instance.serialNumber,
      'mtow': instance.mtow,
      'defaultUnit': instance.defaultUnit,
      'mtowUnit': instance.mtowUnit,
      'iata': instance.iata,
      'icao': instance.icao,
      'runwayFt': instance.runwayFt,
      'referenceCode': instance.referenceCode,
      'remark': instance.remark,
      'customers': instance.customerIds,
      'operatorId': instance.operatorIds,
      'archived': instance.archived,
      'Customers': instance.customerDetails?.map((e) => e.toJson()).toList(),
      'Operators': instance.operatorDetails?.map((e) => e.toJson()).toList(),
    };
