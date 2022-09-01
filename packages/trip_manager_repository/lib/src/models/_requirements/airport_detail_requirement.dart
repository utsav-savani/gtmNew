import 'package:flutter/material.dart';
import 'package:trip_manager_repository/src/models/_requirements/airport_attachment.dart';
import 'package:trip_manager_repository/src/models/_requirements/airport_procedure.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'airport_detail_requirement.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class AirportDetailRequirement extends Equatable {
  final int airportId;
  final String? name;
  final int? countryId;
  final int? cityId;
  final String? iata;
  final String? icao;
  final int? elevation;
  final String? longitude;
  final String? latitude;
  final bool? civil;
  final bool? military;
  final bool? aoe;
  @JsonKey(name: 'UASSupervisorySvc')
  final bool? uASSupervisorySvc;
  final bool? slots;
  @JsonKey(name: 'H24')
  final bool? h24;
  @JsonKey(name: 'USSouthernAOE')
  final bool? uSSouthernAOE;
  @JsonKey(name: 'USLngdRights')
  final bool? uSLngdRights;
  @JsonKey(name: 'USPreClear')
  final bool? uSPreClear;
  final bool? ppr;
  final bool? customs;
  final String? timezone;
  @JsonKey(name: 'DSTOffset')
  final String? dSTOffset;
  final bool? isDST;
  final String? dstStartDate;
  final String? dstEndDate;
  final String? timezoneNote;
  @JsonKey(name: 'Tower')
  final String? tower;
  final String? gmt;
  @JsonKey(name: 'Tower1')
  final String? tower1;
  @JsonKey(name: 'Ground')
  final String? ground;
  @JsonKey(name: 'Ground1')
  final String? ground1;
  @JsonKey(name: 'Clearance')
  final String? clearance;
  @JsonKey(name: 'ATIS')
  final String? aTIS;
  final String? atcNote;
  @JsonKey(name: 'AirportFromHours')
  final String? airportFromHours;
  @JsonKey(name: 'AirportToHours')
  final String? airportToHours;
  @JsonKey(name: 'TowerFromHours')
  final String? towerFromHours;
  @JsonKey(name: 'TowerToHours')
  final String? towerToHours;
  @JsonKey(name: 'AirportHoursUTC')
  final bool? airportHoursUTC;
  @JsonKey(name: 'TowerHoursUTC')
  final bool? towerHoursUTC;
  final String? operatingHoursNote;
  final String? noiseCategory;
  final String? referenceCode;
  final int? fireCategory;
  final String? fireCategoryUpgrade;
  final String? fireCategoryNote;
  final bool? isFireCategoryUpgrade;
  @JsonKey(name: 'JetA1')
  final bool? jetA1;
  @JsonKey(name: 'JetA')
  final bool? jetA;
  @JsonKey(name: 'JetB')
  final bool? jetB;
  @JsonKey(name: 'AVGas')
  final bool? aVGas;
  @JsonKey(name: 'TS1')
  final bool? tS1;
  final String? fuelRestrictions;
  final String? generalRemarks;
  final String? cargoRestrictions;
  final String? generalRemarksCargo;
  @JsonKey(name: 'RunwayLights')
  final String? runwayLights;
  @JsonKey(name: 'ApproachLights')
  final String? approachLights;
  final String? runwayFacilitiesNote;
  @JsonKey(name: 'Commercial')
  final bool? commercial;
  @JsonKey(name: 'CommercialParkingRestrictions')
  final bool? commercialParkingRestrictions;
  @JsonKey(name: 'CommercialNotes')
  final String? commercialNotes;
  @JsonKey(name: 'GeneralAviation')
  final bool? generalAviation;
  @JsonKey(name: 'GeneralAviationParkingRestrictions')
  final bool? generalAviationParkingRestrictions;
  @JsonKey(name: 'GeneralAviationNotes')
  final String? generalAviationNotes;
  @JsonKey(name: 'CustomsFromHours')
  final String? customsFromHours;
  @JsonKey(name: 'CustomsToHours')
  final String? customsToHours;
  @JsonKey(name: 'CustomsHoursUTC')
  final bool? customsHoursUTC;
  final String? bearingToCityCenter;
  final String? drivingTime;
  final String? operationalHours;
  final String? operationalRestrictions;
  final String? operationalPermissions;
  final String? operationalCustoms;
  final String? operationalAgenstLocation;
  final String? operationalMeetingPoint;
  final String? operationalParking;
  final String? taxiTime;
  final bool? archived;
  @JsonKey(name: 'UASPartnerAgent')
  final String? uASPartnerAgent;
  @JsonKey(name: 'RunwayApproaches')
  final List<RunwayApproach>? runwayApproaches;
  @JsonKey(name: 'RunwayInformation')
  final List<RunwayInformation>? runwayInformation;
  @JsonKey(name: 'Alternatives')
  final List<Alternative>? alternatives;
  @JsonKey(name: 'AirportCity')
  final AirportCity? airportCity;
  @JsonKey(name: 'Country')
  final AirportDetailCountry? country;
  @JsonKey(name: 'AirportAttachments')
  final List<AirportAttachment>? airportAttachments;
  @JsonKey(name: 'AirportProcedures')
  final List<AirportProcedure>? airportProcedures;

  const AirportDetailRequirement({
    required this.airportId,
    this.aTIS,
    this.aVGas,
    this.airportFromHours,
    this.airportHoursUTC,
    this.airportToHours,
    this.aoe,
    this.approachLights,
    this.archived,
    this.atcNote,
    this.bearingToCityCenter,
    this.cargoRestrictions,
    this.cityId,
    this.civil,
    this.clearance,
    this.commercial,
    this.commercialNotes,
    this.commercialParkingRestrictions,
    this.countryId,
    this.customs,
    this.customsFromHours,
    this.customsHoursUTC,
    this.customsToHours,
    this.dSTOffset,
    this.drivingTime,
    this.dstEndDate,
    this.dstStartDate,
    this.elevation,
    this.fireCategory,
    this.fireCategoryNote,
    this.fireCategoryUpgrade,
    this.fuelRestrictions,
    this.generalAviation,
    this.generalAviationNotes,
    this.generalAviationParkingRestrictions,
    this.generalRemarks,
    this.generalRemarksCargo,
    this.gmt,
    this.ground,
    this.ground1,
    this.h24,
    this.iata,
    this.icao,
    this.isDST,
    this.isFireCategoryUpgrade,
    this.jetA,
    this.jetA1,
    this.jetB,
    this.latitude,
    this.longitude,
    this.military,
    this.name,
    this.noiseCategory,
    this.operatingHoursNote,
    this.operationalAgenstLocation,
    this.operationalCustoms,
    this.operationalHours,
    this.operationalMeetingPoint,
    this.operationalParking,
    this.operationalPermissions,
    this.operationalRestrictions,
    this.ppr,
    this.referenceCode,
    this.runwayFacilitiesNote,
    this.runwayLights,
    this.slots,
    this.tS1,
    this.taxiTime,
    this.timezone,
    this.timezoneNote,
    this.tower,
    this.tower1,
    this.towerFromHours,
    this.towerHoursUTC,
    this.towerToHours,
    this.uASSupervisorySvc,
    this.uSLngdRights,
    this.uSPreClear,
    this.uSSouthernAOE,
    this.uASPartnerAgent,
    this.runwayApproaches,
    this.runwayInformation,
    this.alternatives,
    this.airportCity,
    this.country,
    this.airportAttachments,
    this.airportProcedures,
  });

  AirportDetailRequirement copyWith({
    required int airportId,
    String? name,
    int? countryId,
    int? cityId,
    String? iata,
    String? icao,
    int? elevation,
    String? longitude,
    String? latitude,
    bool? civil,
    bool? military,
    bool? aoe,
    bool? uASSupervisorySvc,
    bool? slots,
    bool? h24,
    bool? uSSouthernAOE,
    bool? uSLngdRights,
    bool? uSPreClear,
    bool? ppr,
    bool? customs,
    String? timezone,
    String? dSTOffset,
    bool? isDST,
    String? dstStartDate,
    String? dstEndDate,
    String? timezoneNote,
    String? tower,
    String? gmt,
    String? tower1,
    String? ground,
    String? ground1,
    String? clearance,
    String? aTIS,
    String? atcNote,
    String? airportFromHours,
    String? airportToHours,
    String? towerFromHours,
    String? towerToHours,
    bool? airportHoursUTC,
    bool? towerHoursUTC,
    String? operatingHoursNote,
    String? noiseCategory,
    String? referenceCode,
    int? fireCategory,
    String? fireCategoryUpgrade,
    String? fireCategoryNote,
    bool? isFireCategoryUpgrade,
    bool? jetA1,
    bool? jetA,
    bool? jetB,
    bool? aVGas,
    bool? tS1,
    String? fuelRestrictions,
    String? generalRemarks,
    String? cargoRestrictions,
    String? generalRemarksCargo,
    String? runwayLights,
    String? approachLights,
    String? runwayFacilitiesNote,
    bool? commercial,
    bool? commercialParkingRestrictions,
    String? commercialNotes,
    bool? generalAviation,
    bool? generalAviationParkingRestrictions,
    String? generalAviationNotes,
    String? customsFromHours,
    String? customsToHours,
    bool? customsHoursUTC,
    String? bearingToCityCenter,
    String? drivingTime,
    String? operationalHours,
    String? operationalRestrictions,
    String? operationalPermissions,
    String? operationalCustoms,
    String? operationalAgenstLocation,
    String? operationalMeetingPoint,
    String? operationalParking,
    String? taxiTime,
    bool? archived,
    String? uASPartnerAgent,
    List<RunwayApproach>? runwayApproaches,
    List<RunwayInformation>? runwayInformation,
    List<Alternative>? alternatives,
    AirportCity? airportCity,
    AirportDetailCountry? country,
    List<AirportAttachment>? airportAttachments,
    List<AirportProcedure>? airportProcedures,
  }) {
    return AirportDetailRequirement(
      airportId: airportId,
      name: name,
      countryId: countryId,
      cityId: cityId,
      iata: iata,
      icao: icao,
      elevation: elevation,
      longitude: longitude,
      latitude: latitude,
      civil: civil,
      military: military,
      aoe: aoe,
      uASSupervisorySvc: uASSupervisorySvc,
      slots: slots,
      h24: h24,
      uSSouthernAOE: uSSouthernAOE,
      uSLngdRights: uSLngdRights,
      uSPreClear: uSPreClear,
      ppr: ppr,
      customs: customs,
      timezone: timezone,
      dSTOffset: dSTOffset,
      isDST: isDST,
      dstStartDate: dstStartDate,
      dstEndDate: dstEndDate,
      timezoneNote: timezoneNote,
      tower: tower,
      gmt: gmt,
      tower1: tower1,
      ground: ground,
      ground1: ground1,
      clearance: clearance,
      aTIS: aTIS,
      atcNote: atcNote,
      airportFromHours: airportFromHours,
      airportToHours: airportToHours,
      towerFromHours: towerFromHours,
      towerToHours: towerToHours,
      airportHoursUTC: airportHoursUTC,
      towerHoursUTC: towerHoursUTC,
      operatingHoursNote: operatingHoursNote,
      noiseCategory: noiseCategory,
      referenceCode: referenceCode,
      fireCategory: fireCategory,
      fireCategoryUpgrade: fireCategoryUpgrade,
      fireCategoryNote: fireCategoryNote,
      isFireCategoryUpgrade: isFireCategoryUpgrade,
      jetA1: jetA1,
      jetA: jetA,
      jetB: jetB,
      aVGas: aVGas,
      tS1: tS1,
      fuelRestrictions: fuelRestrictions,
      generalRemarks: generalRemarks,
      cargoRestrictions: cargoRestrictions,
      generalRemarksCargo: generalRemarksCargo,
      runwayLights: runwayLights,
      approachLights: approachLights,
      runwayFacilitiesNote: runwayFacilitiesNote,
      commercial: commercial,
      commercialParkingRestrictions: commercialParkingRestrictions,
      commercialNotes: commercialNotes,
      generalAviation: generalAviation,
      generalAviationParkingRestrictions: generalAviationParkingRestrictions,
      generalAviationNotes: generalAviationNotes,
      customsFromHours: customsFromHours,
      customsToHours: customsToHours,
      customsHoursUTC: customsHoursUTC,
      bearingToCityCenter: bearingToCityCenter,
      drivingTime: drivingTime,
      operationalHours: operationalHours,
      operationalRestrictions: operationalRestrictions,
      operationalPermissions: operationalPermissions,
      operationalCustoms: operationalCustoms,
      operationalAgenstLocation: operationalAgenstLocation,
      operationalMeetingPoint: operationalMeetingPoint,
      operationalParking: operationalParking,
      taxiTime: taxiTime,
      archived: archived,
      uASPartnerAgent: uASPartnerAgent,
      runwayApproaches: runwayApproaches,
      runwayInformation: runwayInformation,
      alternatives: alternatives,
      airportCity: airportCity,
      country: country,
      airportAttachments: airportAttachments,
      airportProcedures: airportProcedures,
    );
  }

  /// Deserializes the given [JsonMap] into a [AirportDetailRequirement].
  static AirportDetailRequirement fromJson(JsonMap json) =>
      _$AirportDetailRequirementFromJson(json);

  /// Converts this [AirportDetailRequirement] into a [JsonMap].
  JsonMap toJson() => _$AirportDetailRequirementToJson(this);

  @override
  List<Object?> get props => [
        airportId,
        name,
        countryId,
        cityId,
        iata,
        icao,
        elevation,
        longitude,
        latitude,
        civil,
        military,
        aoe,
        uASSupervisorySvc,
        slots,
        h24,
        uSSouthernAOE,
        uSLngdRights,
        uSPreClear,
        ppr,
        customs,
        timezone,
        dSTOffset,
        isDST,
        dstStartDate,
        dstEndDate,
        timezoneNote,
        tower,
        gmt,
        tower1,
        ground,
        ground1,
        clearance,
        aTIS,
        atcNote,
        airportFromHours,
        airportToHours,
        towerFromHours,
        towerToHours,
        airportHoursUTC,
        towerHoursUTC,
        operatingHoursNote,
        noiseCategory,
        referenceCode,
        fireCategory,
        fireCategoryUpgrade,
        fireCategoryNote,
        isFireCategoryUpgrade,
        jetA1,
        jetA,
        jetB,
        aVGas,
        tS1,
        fuelRestrictions,
        generalRemarks,
        cargoRestrictions,
        generalRemarksCargo,
        runwayLights,
        approachLights,
        runwayFacilitiesNote,
        commercial,
        commercialParkingRestrictions,
        commercialNotes,
        generalAviation,
        generalAviationParkingRestrictions,
        generalAviationNotes,
        customsFromHours,
        customsToHours,
        customsHoursUTC,
        bearingToCityCenter,
        drivingTime,
        operationalHours,
        operationalRestrictions,
        operationalPermissions,
        operationalCustoms,
        operationalAgenstLocation,
        operationalMeetingPoint,
        operationalParking,
        taxiTime,
        archived,
        runwayInformation,
        runwayApproaches,
        alternatives,
        airportCity,
        country,
        airportAttachments,
        airportProcedures,
      ];
}
