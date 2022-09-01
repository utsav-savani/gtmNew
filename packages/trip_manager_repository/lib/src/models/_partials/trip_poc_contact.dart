import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';
import 'package:trip_manager_repository/src/models/_partials/trip_call_record.dart';

part 'trip_poc_contact.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripPOCContact extends Equatable {
  @JsonKey(name: 'Name')
  final String name;
  final int priority;
  final int customercontactId;
  final List<String>? mobiles;
  final List<String>? phones;
  final List<String>? emails;
  final List<TripCallRecord>? callRecords;

  const TripPOCContact({
    required this.name,
    required this.priority,
    required this.customercontactId,
    this.mobiles,
    this.phones,
    this.emails,
    this.callRecords,
  });

  TripPOCContact copyWith({
    required String name,
    required int priority,
    required int customercontactId,
    required List<String>? mobiles,
    required List<String>? phones,
    required List<String>? emails,
    required List<TripCallRecord>? callRecords,
  }) {
    return TripPOCContact(
      name: name,
      customercontactId: customercontactId,
      priority: priority,
      mobiles: mobiles,
      phones: phones,
      emails: emails,
      callRecords: callRecords,
    );
  }

  /// Deserializes the given [JsonMap] into a [Trip].
  static TripPOCContact fromJson(JsonMap json) =>
      _$TripPOCContactFromJson(json);

  /// Converts this [Trip] into a [JsonMap].
  JsonMap toJson() => _$TripPOCContactToJson(this);

  @override
  List<Object?> get props =>
      [name, customercontactId, priority, callRecords, mobiles, phones, emails];
}
