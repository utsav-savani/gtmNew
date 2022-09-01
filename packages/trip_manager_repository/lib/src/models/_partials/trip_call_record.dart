import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';

part 'trip_call_record.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripCallRecord extends Equatable {
  @JsonKey(name: 'Contact Type')
  final String contactType;
  @JsonKey(name: 'Medium')
  final String medium;
  @JsonKey(name: 'Info')
  final String info;
  final List<String>? purposes;

  const TripCallRecord({
    required this.contactType,
    required this.medium,
    required this.info,
    this.purposes,
  });

  TripCallRecord copyWith({
    required String contactType,
    required String medium,
    required String info,
    List<String>? purposes,
  }) {
    return TripCallRecord(
      contactType: contactType,
      info: info,
      medium: medium,
      purposes: purposes,
    );
  }

  /// Deserializes the given [JsonMap] into a [Trip].
  static TripCallRecord fromJson(JsonMap json) =>
      _$TripCallRecordFromJson(json);

  /// Converts this [Trip] into a [JsonMap].
  JsonMap toJson() => _$TripCallRecordToJson(this);

  @override
  List<Object?> get props => [contactType, info, medium, purposes];
}
