import 'package:flutter/material.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'trip_pob_office.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripPobOffice extends Equatable {
  final String? website;
  final String? email;
  final String? mobile;
  final String? fax;
  final String? contact;
  final String? aftn;
  final String? sita;
  final String? address;
  final String? fullName;

  TripPobOffice({
    required this.website,
    required this.email,
    required this.mobile,
    required this.fax,
    required this.contact,
    required this.aftn,
    required this.sita,
    required this.address,
    required this.fullName,
  });

  TripPobOffice copyWith({
    required String? website,
    required String? email,
    required String? mobile,
    required String? fax,
    required String? contact,
    required String? aftn,
    required String? sita,
    required String? address,
    required String? fullName,
  }) {
    return TripPobOffice(
      website: website,
      email: email,
      mobile: mobile,
      fax: fax,
      contact: contact,
      aftn: aftn,
      sita: sita,
      address: address,
      fullName: fullName,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripPobOffice].
  static TripPobOffice fromJson(JsonMap json) => _$TripPobOfficeFromJson(json);

  /// Converts this [TripPobOffice] into a [JsonMap].
  JsonMap toJson() => _$TripPobOfficeToJson(this);

  @override
  List<Object?> get props => [
        website,
        email,
        mobile,
        fax,
        contact,
        aftn,
        sita,
        address,
        fullName,
      ];
}
