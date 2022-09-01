import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';

part 'trip_data_response.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripDataResponse extends Equatable {
   String? message;
   bool? isPullForBilling;
   bool? isRevised;
   bool? tripCostEstimate;
   String? fileStatus;
   int? tripId;
   int? officeId;
   int? customerId;
   int? flightCategoryId;
   int? aircraftId;
   int? operatorId;
   String? customerReference;
   String? linemode;
   String? tripStatus;
   String? creatorId;
   String? tripNumber;
   String? guid;
   String? updatedAt;
   String? createdAt;
  @JsonKey(name: 'TCERef')
   bool? oldTripStatus;
   String? tCERef;
   String? serviceList;

  TripDataResponse.inital();

  TripDataResponse({
    required this.message,
    required this.isPullForBilling,
    required this.isRevised,
    required this.tripCostEstimate,
    required this.fileStatus,
    required this.tripId,
    required this.officeId,
    required this.customerId,
    required this.flightCategoryId,
    required this.aircraftId,
    required this.operatorId,
    required this.customerReference,
    this.linemode,
    required this.tripStatus,
    required this.creatorId,
    required this.tripNumber,
    required this.guid,
    required this.updatedAt,
    required this.createdAt,
    this.oldTripStatus,
    this.serviceList,
    this.tCERef,
  });

  TripDataResponse copyWith({
    required String message,
    required bool isPullForBilling,
    required bool isRevised,
    required bool tripCostEstimate,
    required String fileStatus,
    required int tripId,
    required int officeId,
    required int customerId,
    required int flightCategoryId,
    required int aircraftId,
    required int operatorId,
    required String customerReference,
    String? linemode,
    required String tripStatus,
    required String creatorId,
    required String tripNumber,
    required String guid,
    required String updatedAt,
    required String createdAt,
    required bool oldTripStatus,
    String? serviceList,
    String? tCERef,
  }) {
    return TripDataResponse(
      message: message,
      aircraftId: aircraftId,
      createdAt: createdAt,
      creatorId: creatorId,
      customerId: customerId,
      customerReference: customerReference,
      fileStatus: fileStatus,
      flightCategoryId: flightCategoryId,
      guid: guid,
      isPullForBilling: isPullForBilling,
      isRevised: isRevised,
      officeId: officeId,
      operatorId: operatorId,
      tripCostEstimate: tripCostEstimate,
      tripId: tripId,
      tripNumber: tripNumber,
      tripStatus: tripStatus,
      updatedAt: updatedAt,
      linemode: linemode,
      oldTripStatus: oldTripStatus,
      serviceList: serviceList,
      tCERef: tCERef,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripDataResponse].
  static TripDataResponse fromJson(JsonMap json) =>
      _$TripDataResponseFromJson(json);

  /// Converts this [TripDataResponse] into a [JsonMap].
  JsonMap toJson() => _$TripDataResponseToJson(this);

  @override
  List<Object?> get props => [
        message,
        aircraftId,
        createdAt,
        creatorId,
        customerId,
        customerReference,
        fileStatus,
        flightCategoryId,
        guid,
        isPullForBilling,
        isRevised,
        officeId,
        operatorId,
        tripCostEstimate,
        tripId,
        tripNumber,
        tripStatus,
        updatedAt,
      ];
}
