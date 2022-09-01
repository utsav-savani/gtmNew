import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';

part 'trip.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Trip extends Equatable {
  final int tripId;
  final String guid;
  final String tripNumber;
  final String tripStatus;
  final String fileStatus;
  final int customerId;
  final String customer;
  final String regNo;
  final String operator;
  final String acType;
  final String team;
  final bool isFlightCategory;
  final String flightCategory;
  final String callsign;
  final String start;
  final String end;
  final List<String>? route;
  final String creator;

  const Trip({
    required this.tripId,
    required this.guid,
    required this.tripNumber,
    required this.tripStatus,
    required this.fileStatus,
    required this.customerId,
    required this.customer,
    required this.regNo,
    required this.operator,
    required this.acType,
    required this.team,
    required this.isFlightCategory,
    required this.flightCategory,
    required this.callsign,
    required this.start,
    required this.end,
    required this.route,
    required this.creator,
  });

  Trip copyWith({
    required int tripId,
    required String guid,
    required String tripNumber,
    required String tripStatus,
    required String fileStatus,
    required int customerId,
    required String customer,
    required String regNo,
    required String operator,
    required String acType,
    required String team,
    required bool isFlightCategory,
    required String flightCategory,
    required String callsign,
    required String start,
    required String end,
    required List<String>? route,
    required String creator,
  }) {
    return Trip(
      tripId: tripId,
      guid: guid,
      acType: acType,
      callsign: callsign,
      creator: creator,
      customer: customer,
      customerId: customerId,
      end: end,
      fileStatus: fileStatus,
      flightCategory: flightCategory,
      isFlightCategory: isFlightCategory,
      operator: operator,
      regNo: regNo,
      route: route,
      start: start,
      team: team,
      tripNumber: tripNumber,
      tripStatus: tripStatus,
    );
  }

  /// Deserializes the given [JsonMap] into a [Trip].
  static Trip fromJson(JsonMap json) => _$TripFromJson(json);

  /// Converts this [Trip] into a [JsonMap].
  JsonMap toJson() => _$TripToJson(this);

  @override
  List<Object?> get props => [tripId, tripNumber, tripStatus];
}
