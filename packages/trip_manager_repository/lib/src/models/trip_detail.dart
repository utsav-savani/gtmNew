import 'package:flutter/material.dart';
import 'package:trip_manager_repository/src/models.dart';
import 'package:trip_manager_repository/src/models/_partials/operational_note.dart';
import 'package:trip_manager_repository/src/models/_partials/primary_aircraft.dart';

part 'trip_detail.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripDetail extends Equatable {
  String? tripNumber;
  int? customerId;
  int? operatorId;
  bool? isRevised;
  String? guid;
  @JsonKey(name: 'TCERef')
  String? tCERef;
  bool? isPullForBilling;
  int? flightCategoryId;
  int? officeId;
  int? primaryAircraftId;
  String? tripStatus;
  String? fileStatus;
  String? customerReference;
  String? createdAt;
  String? tripOwnerId;
  bool? tripCostEstimate;
  String? operatorName;
  String? customerName;
  String? tripOwnerName;
  String? accountStatus;
  String? officeName;
  String? officeFullName;
  PrimaryAircraft? primaryAircraft;
  List<PrimaryAircraft>? childAircraft;
  @JsonKey(name: 'OperationalNotes')
  List<OperationalNote>? operationalNotes;
  @JsonKey(name: 'POCContact')
  List<TripPOCContact>? pOCContact;

  TripDetail.initial();

  TripDetail({
    required this.tripNumber,
    required this.guid,
    required this.customerId,
    required this.operatorId,
    required this.isRevised,
    required this.tCERef,
    required this.isPullForBilling,
    required this.flightCategoryId,
    required this.officeId,
    required this.primaryAircraftId,
    required this.tripStatus,
    required this.fileStatus,
    required this.customerReference,
    required this.createdAt,
    this.tripOwnerId,
    required this.tripCostEstimate,
    this.operatorName,
    this.customerName,
    this.tripOwnerName,
    this.accountStatus,
    this.officeName,
    this.officeFullName,
    this.primaryAircraft,
    this.childAircraft,
    this.operationalNotes,
    this.pOCContact,
  });

  TripDetail copyWith({
    required String tripNumber,
    required String guid,
    required int customerId,
    required int operatorId,
    required bool isRevised,
    String? tCERef,
    required bool isPullForBilling,
    required int flightCategoryId,
    required int officeId,
    required int primaryAircraftId,
    required String tripStatus,
    required String fileStatus,
    required String customerReference,
    required String createdAt,
    String? tripOwnerId,
    required bool tripCostEstimate,
    String? operatorName,
    String? customerName,
    String? tripOwnerName,
    List<PrimaryAircraft>? childAircraft,
    String? accountStatus,
    String? officeName,
    String? officeFullName,
    PrimaryAircraft? primaryAircraft,
    List<OperationalNote>? operationalNote,
    List<TripPOCContact>? pOCContact,
  }) {
    return TripDetail(
      tripNumber: tripNumber,
      guid: guid,
      customerId: customerId,
      operatorId: operatorId,
      isRevised: isRevised,
      tCERef: tCERef,
      isPullForBilling: isPullForBilling,
      flightCategoryId: flightCategoryId,
      officeId: officeId,
      primaryAircraftId: primaryAircraftId,
      tripStatus: tripStatus,
      fileStatus: fileStatus,
      customerReference: customerReference,
      createdAt: createdAt,
      tripOwnerId: tripOwnerId,
      tripCostEstimate: tripCostEstimate,
      operatorName: operatorName,
      customerName: customerName,
      tripOwnerName: tripOwnerName,
      childAircraft: childAircraft,
      accountStatus: accountStatus,
      officeName: officeName,
      officeFullName: officeFullName,
      primaryAircraft: primaryAircraft,
      operationalNotes: operationalNotes,
      pOCContact: pOCContact,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripDetail].
  static TripDetail fromJson(JsonMap json) => _$TripDetailFromJson(json);

  /// Converts this [TripDetail] into a [JsonMap].
  JsonMap toJson() => _$TripDetailToJson(this);

  @override
  List<Object?> get props => [
        tripNumber,
        guid,
        customerId,
        operatorId,
        isRevised,
        tCERef,
        isPullForBilling,
        flightCategoryId,
        officeId,
        primaryAircraftId,
        tripStatus,
        fileStatus,
        customerReference,
        createdAt,
        tripOwnerId,
        tripCostEstimate,
        operatorName,
        customerName,
        tripOwnerName,
        childAircraft,
        accountStatus,
        officeName,
        officeFullName,
        primaryAircraft,
        operationalNotes,
        pOCContact,
      ];
}
