import 'package:airport_repository/airport_repository.dart';
import 'package:airport_repository/config/typedef_json.dart';
import 'package:airport_repository/src/models.dart';
import 'package:airport_repository/src/models/airport_attachment.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'airport_general_info.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class AirportGeneralInfo extends Equatable {
  // GENERALINFO
  final int airportId;
  final String name;
  final int countryId;
  final int? cityId;
  final String iata;
  final String icao;
  final int elevation;
  final String longitude;
  final String latitude;
  final String? bearingToCityCenter;
  final String? drivingTime;
  @JsonKey(name: 'AirportCity')
  final AirportCity? airportCity;
  @JsonKey(name: 'Country')
  final AirportCountry country;
  final List<String>? Alternatives;

  // TYPE/RESTRICTIONS
  final bool civil;
  final bool military;
  final bool aoe;
  final bool UASSupervisorySvc;
  final bool slots;
  final bool H24;
  final bool USSouthernAOE;
  final bool USLngdRights;
  final bool USPreClear;
  final bool ppr;
  final bool customs;

  // RUNWAYINFO
  final List<String>? RunwayInformation;

  // TIMEZONE
  final String gmt;
  final String timezone;
  final String DSTOffset;
  final bool isDST;
  final String? dstStartDate;
  final String? dstEndDate;
  final String timezoneNote;

  // ATCFREQ
  final String Tower;
  final String Tower1;
  final String Ground;
  final String Ground1;
  final String Clearance;
  final String ATIS;
  final String atcNote;

  // HOURS
  final String? AirportFromHours;
  final String? AirportToHours;
  final String? TowerFromHours;
  final String? TowerToHours;
  final bool? AirportHoursUTC;
  final bool? TowerHoursUTC;
  final String operatingHoursNote;

  // CATEG
  final String? noiseCategory;
  final String? referenceCode;
  final int? fireCategory;
  final String? fireCategoryUpgrade;
  final String? fireCategoryNote;
  final bool isFireCategoryUpgrade;

  // FUEL
  final bool JetA1;
  final bool JetA;
  final bool JetB;
  final bool AVGas;
  final bool TS1;
  final String fuelRestrictions;

  // GENERALREMARKS
  final String generalRemarks;

  // CARGO
  final String cargoRestrictions;
  final String generalRemarksCargo;

  // AIRPORTFACILITIES
  final String? RunwayLights;
  final String? ApproachLights;
  final List<String>? RunwayApproaches;
  final String runwayFacilitiesNote;
  final bool Commercial;
  final bool GeneralAviation;
  final bool CommercialParkingRestrictions;
  final bool GeneralAviationParkingRestrictions;

  // OPERATIONALNOTES
  final String? operationalHours;
  final String? operationalRestrictions;
  final String? operationalPermissions;
  final String? operationalCustoms;
  final String? operationalAgenstLocation;
  final String? operationalMeetingPoint;
  final String? operationalParking;
  final String? taxiTime;

  // ATTACHEMENTS
  @JsonKey(name: 'AirportAttachments')
  final List<AirportAttachment> airportAttachmentsList;

  final bool archived;

  // =========

  final String CommercialNotes;
  final String GeneralAviationNotes;
  @JsonKey(name: 'AirportProcedures')
  final List<String>? airportProceduresList;

  final String CustomsFromHours;
  final String CustomsToHours;
  final bool CustomsHoursUTC;

  @JsonKey(name: 'UASPartnerAgent')
  final String uASPartnerAgent;

  // =========

  const AirportGeneralInfo({
    required this.airportId,
    required this.name,
    required this.countryId,
    this.cityId,
    required this.iata,
    required this.icao,
    required this.elevation,
    required this.longitude,
    required this.latitude,
    required this.civil,
    required this.military,
    required this.aoe,
    required this.UASSupervisorySvc,
    required this.slots,
    required this.H24,
    required this.USSouthernAOE,
    required this.USLngdRights,
    required this.USPreClear,
    required this.ppr,
    required this.customs,
    required this.timezone,
    required this.DSTOffset,
    required this.isDST,
    this.dstStartDate,
    this.dstEndDate,
    required this.timezoneNote,
    required this.Tower,
    required this.gmt,
    required this.Tower1,
    required this.Ground,
    required this.Ground1,
    required this.Clearance,
    required this.ATIS,
    required this.atcNote,
    this.AirportFromHours,
    this.AirportToHours,
    this.TowerFromHours,
    this.TowerToHours,
    this.AirportHoursUTC,
    this.TowerHoursUTC,
    required this.operatingHoursNote,
    this.noiseCategory,
    this.referenceCode,
    this.fireCategory,
    this.fireCategoryUpgrade,
    required this.fireCategoryNote,
    required this.isFireCategoryUpgrade,
    required this.JetA1,
    required this.JetA,
    required this.JetB,
    required this.AVGas,
    required this.TS1,
    required this.fuelRestrictions,
    required this.generalRemarks,
    required this.cargoRestrictions,
    required this.generalRemarksCargo,
    this.RunwayLights,
    this.ApproachLights,
    required this.runwayFacilitiesNote,
    required this.Commercial,
    required this.CommercialParkingRestrictions,
    required this.CommercialNotes,
    required this.GeneralAviation,
    required this.GeneralAviationParkingRestrictions,
    required this.GeneralAviationNotes,
    required this.CustomsFromHours,
    required this.CustomsToHours,
    required this.CustomsHoursUTC,
    this.bearingToCityCenter,
    this.drivingTime,
    this.operationalHours,
    this.operationalRestrictions,
    this.operationalPermissions,
    this.operationalCustoms,
    this.operationalAgenstLocation,
    this.operationalMeetingPoint,
    this.operationalParking,
    this.taxiTime,
    required this.archived,
    this.RunwayApproaches,
    this.RunwayInformation,
    this.Alternatives,
    this.airportCity,
    required this.uASPartnerAgent,
    required this.country,
    required this.airportAttachmentsList,
    this.airportProceduresList,
  });

  AirportGeneralInfo copyWith({
    required int airportId,
    required String name,
    required int countryId,
    int? cityId,
    required String iata,
    required String icao,
    required int elevation,
    required String longitude,
    required String latitude,
    required bool civil,
    required bool military,
    required bool aoe,
    required bool UASSupervisorySvc,
    required bool slots,
    required bool H24,
    required bool USSouthernAOE,
    required bool USLngdRights,
    required bool USPreClear,
    required bool ppr,
    required bool customs,
    required String timezone,
    required String DSTOffset,
    required bool isDST,
    String? dstStartDate,
    String? dstEndDate,
    required String timezoneNote,
    required String Tower,
    required String gmt,
    required String Tower1,
    required String Ground,
    required String Ground1,
    required String Clearance,
    required String ATIS,
    required String atcNote,
    String? AirportFromHours,
    String? AirportToHours,
    String? TowerFromHours,
    String? TowerToHours,
    bool? AirportHoursUTC,
    bool? TowerHoursUTC,
    required String operatingHoursNote,
    String? noiseCategory,
    String? referenceCode,
    required int fireCategory,
    String? fireCategoryUpgrade,
    required String fireCategoryNote,
    required bool isFireCategoryUpgrade,
    required bool JetA1,
    required bool JetA,
    required bool JetB,
    required bool AVGas,
    required bool TS1,
    required String fuelRestrictions,
    required String generalRemarks,
    required String cargoRestrictions,
    required String generalRemarksCargo,
    String? RunwayLights,
    String? ApproachLights,
    required String runwayFacilitiesNote,
    required bool Commercial,
    required bool CommercialParkingRestrictions,
    required String CommercialNotes,
    required bool GeneralAviation,
    required bool GeneralAviationParkingRestrictions,
    required String GeneralAviationNotes,
    required String CustomsFromHours,
    required String CustomsToHours,
    required bool CustomsHoursUTC,
    String? bearingToCityCenter,
    String? drivingTime,
    required String operationalHours,
    String? operationalRestrictions,
    String? operationalPermissions,
    String? operationalCustoms,
    String? operationalAgenstLocation,
    String? operationalMeetingPoint,
    String? operationalParking,
    String? taxiTime,
    required bool archived,
    List<String>? RunwayApproaches,
    List<String>? RunwayInformation,
    List<String>? Alternatives,
    AirportCity? AirportCity,
    required String uASPartnerAgent,
    required AirportCountry country,
    List<AirportAttachment>? airportAttachmentsList,
    List<String>? airportProceduresList,
  }) {
    return AirportGeneralInfo(
        airportId: airportId,
        name: name,
        countryId: countryId,
        iata: iata,
        icao: icao,
        elevation: elevation,
        longitude: longitude,
        latitude: latitude,
        civil: civil,
        military: military,
        aoe: aoe,
        UASSupervisorySvc: UASSupervisorySvc,
        slots: slots,
        H24: H24,
        USSouthernAOE: USSouthernAOE,
        USLngdRights: USLngdRights,
        USPreClear: USPreClear,
        ppr: ppr,
        customs: customs,
        timezone: timezone,
        DSTOffset: DSTOffset,
        isDST: isDST,
        timezoneNote: timezoneNote,
        Tower: Tower,
        gmt: gmt,
        Tower1: Tower1,
        Ground: Ground,
        Ground1: Ground1,
        Clearance: Clearance,
        ATIS: ATIS,
        atcNote: atcNote,
        operatingHoursNote: operatingHoursNote,
        fireCategory: fireCategory,
        fireCategoryNote: fireCategoryNote,
        isFireCategoryUpgrade: isFireCategoryUpgrade,
        JetA1: JetA1,
        JetA: JetA,
        JetB: JetB,
        AVGas: AVGas,
        TS1: TS1,
        fuelRestrictions: fuelRestrictions,
        generalRemarks: generalRemarks,
        cargoRestrictions: cargoRestrictions,
        generalRemarksCargo: generalRemarksCargo,
        runwayFacilitiesNote: runwayFacilitiesNote,
        Commercial: Commercial,
        CommercialParkingRestrictions: CommercialParkingRestrictions,
        CommercialNotes: CommercialNotes,
        GeneralAviation: GeneralAviation,
        GeneralAviationParkingRestrictions: GeneralAviationParkingRestrictions,
        GeneralAviationNotes: GeneralAviationNotes,
        CustomsFromHours: CustomsFromHours,
        CustomsToHours: CustomsToHours,
        CustomsHoursUTC: CustomsHoursUTC,
        operationalHours: operationalHours,
        archived: archived,
        uASPartnerAgent: uASPartnerAgent,
        airportAttachmentsList: airportAttachmentsList!,
        country: country,
        airportCity: AirportCity);
  }

  /// Deserializes the given [JsonMap] into a [AirportGeneralInfo].
  static AirportGeneralInfo fromJson(JsonMap json) =>
      _$AirportGeneralInfoFromJson(json);

  /// Converts this [AirportGeneralInfo] into a [JsonMap].
  JsonMap toJson() => _$AirportGeneralInfoToJson(this);

  @override
  List<Object?> get props => [
        airportId,
        name,
        countryId,
        iata,
        icao,
        elevation,
        longitude,
        latitude,
        civil,
        military,
        aoe,
        UASSupervisorySvc,
        slots,
        H24,
        USSouthernAOE,
        USLngdRights,
        USPreClear,
        ppr,
        customs,
        timezone,
        DSTOffset,
        isDST,
        timezoneNote,
        Tower,
        gmt,
        Tower1,
        Ground,
        Ground1,
        Clearance,
        ATIS,
        atcNote,
        operatingHoursNote,
        fireCategory,
        fireCategoryNote,
        isFireCategoryUpgrade,
        JetA1,
        JetA,
        JetB,
        AVGas,
        TS1,
        fuelRestrictions,
        generalRemarks,
        cargoRestrictions,
        generalRemarksCargo,
        runwayFacilitiesNote,
        Commercial,
        CommercialParkingRestrictions,
        CommercialNotes,
        GeneralAviation,
        GeneralAviationParkingRestrictions,
        GeneralAviationNotes,
        CustomsFromHours,
        CustomsToHours,
        CustomsHoursUTC,
        operationalHours,
        archived,
        uASPartnerAgent,
        airportAttachmentsList,
        country,
      ];
}
