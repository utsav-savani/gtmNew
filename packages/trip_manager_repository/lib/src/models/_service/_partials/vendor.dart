import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';

part 'vendor.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Vendor extends Equatable {
  final String? fullName;
  final String? vendor;
  final List<String>? email;
  final List<String>? fax;
  final List<String>? phone;
  final List<String>? mobile;

  const Vendor({
    this.fullName,
    this.vendor,
    this.email,
    this.fax,
    this.phone,
    this.mobile,
  });

  Vendor copyWith({
    String? fullName,
    String? vendor,
    List<String>? email,
    List<String>? fax,
    List<String>? phone,
    List<String>? mobile,
  }) {
    return Vendor(
      fullName: fullName,
      vendor: vendor,
      email: email,
      fax: fax,
      phone: phone,
      mobile: mobile,
    );
  }

  /// Deserializes the given [JsonMap] into a [Vendor].
  static Vendor fromJson(JsonMap json) => _$VendorFromJson(json);

  /// Converts this [Vendor] into a [JsonMap].
  JsonMap toJson() => _$VendorToJson(this);

  @override
  List<Object?> get props => [fullName, vendor, email, fax, phone, mobile];
}
