// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:user_repository/src/model/json_map.dart';

part 'office.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Office extends Equatable {
  final int officeId;
  final String officeName;
  final String fullName;
  final String email;
  final String website;
  final String contact;
  final String mobile;
  final String address;

  const Office({
    required this.officeId,
    required this.officeName,
    required this.fullName,
    required this.email,
    required this.website,
    required this.contact,
    required this.mobile,
    required this.address,
  });

  Office copyWith({
    required int officeId,
    required String officeName,
    required String fullName,
    required String email,
    required String website,
    required String contact,
    required String mobile,
    required String address,
  }) {
    return Office(
      officeId: officeId,
      officeName: officeName,
      fullName: fullName,
      email: email,
      website: website,
      contact: contact,
      mobile: mobile,
      address: address,
    );
  }

  /// Deserializes the given [JsonMap] into a [Office].
  static Office fromJson(JsonMap json) => _$OfficeFromJson(json);

  /// Converts this [Office] into a [JsonMap].
  JsonMap toJson() => _$OfficeToJson(this);

  @override
  String toString() {
    return officeName;
  }

  @override
  List<Object?> get props => [
        officeId,
        officeName,
        fullName,
        email,
        website,
        contact,
        mobile,
        address,
      ];
}
