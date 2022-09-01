import 'package:flutter/material.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'trip_pob_schedule_detail.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripPobScheduleDetail extends Equatable {
  final String? tripNumber;
  final int? tripobId;
  final int? personId;
  final String? firstName;
  final String? lastName;
  final String? dob;
  final String? gender;
  final String? countryofresidence;
  final String? countryofresidencecode;
  @JsonKey(name: 'ETA')
  final String? eTA;
  final String? nextarrival;
  final String? nextarrivalLocal;
  final String? stayVal;
  @JsonKey(name: 'ETD')
  final String? eTD;
  final String? flightPurpose;
  final String? category;
  final String? registrationNumber;
  final String? make;
  final String? operatorname;
  @JsonKey(name: 'FBOFName')
  final String? fBOFName;
  final String? sourcepoint;
  final String? destinationpoint;
  final String? sourcepointwithicaoiata;
  final String? destinationpointwithicaoiata;
  @JsonKey(name: 'Type')
  final String? type;
  final int? personPassportDocumentId;
  final String? passportNumber;
  final String? passportIssueDate;
  final String? passportExpireDate;
  final int? passportId;
  final String? pref;
  final String? nationality;
  final String? nationalityISOCode;
  final int? tripsequenceNumber;
  final int? tripScheduleId;
  final int? noOfcrew;
  final int? noOfPassenger;
  final String? sourceCountry;
  final String? destinationCountry;
  final String? baseAirport;

  const TripPobScheduleDetail({
    this.baseAirport,
    this.category,
    this.countryofresidence,
    this.countryofresidencecode,
    this.destinationCountry,
    this.destinationpoint,
    this.destinationpointwithicaoiata,
    this.dob,
    this.eTA,
    this.eTD,
    this.fBOFName,
    this.firstName,
    this.flightPurpose,
    this.gender,
    this.lastName,
    this.make,
    this.nationality,
    this.nationalityISOCode,
    this.nextarrival,
    this.nextarrivalLocal,
    this.noOfPassenger,
    this.noOfcrew,
    this.operatorname,
    this.passportExpireDate,
    this.passportId,
    this.passportIssueDate,
    this.passportNumber,
    this.personId,
    this.personPassportDocumentId,
    this.pref,
    this.registrationNumber,
    this.sourceCountry,
    this.sourcepoint,
    this.sourcepointwithicaoiata,
    this.stayVal,
    this.tripNumber,
    this.tripScheduleId,
    this.tripobId,
    this.tripsequenceNumber,
    this.type,
  });

  TripPobScheduleDetail copyWith({
    String? tripNumber,
    int? tripobId,
    int? personId,
    String? firstName,
    String? lastName,
    String? dob,
    String? gender,
    String? countryofresidence,
    String? countryofresidencecode,
    String? eTA,
    String? nextarrival,
    String? nextarrivalLocal,
    String? stayVal,
    String? eTD,
    String? flightPurpose,
    String? category,
    String? registrationNumber,
    String? make,
    String? operatorname,
    String? fBOFName,
    String? sourcepoint,
    String? destinationpoint,
    String? sourcepointwithicaoiata,
    String? destinationpointwithicaoiata,
    String? type,
    int? personPassportDocumentId,
    String? passportNumber,
    String? passportIssueDate,
    String? passportExpireDate,
    int? passportId,
    String? pref,
    String? nationality,
    String? nationalityISOCode,
    int? tripsequenceNumber,
    int? tripScheduleId,
    int? noOfcrew,
    int? noOfPassenger,
    String? sourceCountry,
    String? destinationCountry,
    String? baseAirport,
  }) {
    return TripPobScheduleDetail(
      tripNumber: tripNumber,
      tripobId: tripobId,
      personId: personId,
      firstName: firstName,
      lastName: lastName,
      dob: dob,
      gender: gender,
      countryofresidence: countryofresidence,
      countryofresidencecode: countryofresidencecode,
      eTA: eTA,
      nextarrival: nextarrival,
      nextarrivalLocal: nextarrivalLocal,
      stayVal: stayVal,
      eTD: eTD,
      flightPurpose: flightPurpose,
      category: category,
      registrationNumber: registrationNumber,
      make: make,
      operatorname: operatorname,
      fBOFName: fBOFName,
      sourcepoint: sourcepoint,
      destinationpoint: destinationpoint,
      sourcepointwithicaoiata: sourcepointwithicaoiata,
      destinationpointwithicaoiata: destinationpointwithicaoiata,
      type: type,
      personPassportDocumentId: personPassportDocumentId,
      passportNumber: passportNumber,
      passportIssueDate: passportIssueDate,
      passportExpireDate: passportExpireDate,
      passportId: passportId,
      pref: pref,
      nationality: nationality,
      nationalityISOCode: nationalityISOCode,
      tripsequenceNumber: tripsequenceNumber,
      tripScheduleId: tripScheduleId,
      noOfcrew: noOfcrew,
      noOfPassenger: noOfPassenger,
      sourceCountry: sourceCountry,
      destinationCountry: destinationCountry,
      baseAirport: baseAirport,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripPobScheduleDetail].
  static TripPobScheduleDetail fromJson(JsonMap json) =>
      _$TripPobScheduleDetailFromJson(json);

  /// Converts this [TripPobScheduleDetail] into a [JsonMap].
  JsonMap toJson() => _$TripPobScheduleDetailToJson(this);

  @override
  List<Object?> get props => [
        tripNumber,
        tripobId,
        personId,
        firstName,
        lastName,
        dob,
        gender,
        countryofresidence,
        countryofresidencecode,
        eTA,
        nextarrival,
        nextarrivalLocal,
        stayVal,
        eTD,
        flightPurpose,
        category,
        registrationNumber,
        make,
        operatorname,
        fBOFName,
        sourcepoint,
        destinationpoint,
        sourcepointwithicaoiata,
        destinationpointwithicaoiata,
        type,
        personPassportDocumentId,
        passportNumber,
        passportIssueDate,
        passportExpireDate,
        passportId,
        pref,
        nationality,
        nationalityISOCode,
        tripsequenceNumber,
        tripScheduleId,
        noOfcrew,
        noOfPassenger,
        sourceCountry,
        destinationCountry,
        baseAirport,
      ];
}
