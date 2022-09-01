import 'package:flutter/material.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'trip_pob_schedule.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripPobSchedule extends Equatable {
  final int tripScheduleId;
  final int tripId;
  final int tripsequenceNumber;
  @JsonKey(name: 'ETA')
  final String? eTa;
  @JsonKey(name: 'ETD')
  final String? eTD;
  @JsonKey(name: 'ETATBA')
  final bool? eTATBA;
  @JsonKey(name: 'ETDTBA')
  final bool? eTDTBA;
  @JsonKey(name: 'NoofCrews')
  final int? noofCrews;
  @JsonKey(name: 'NoofPassengers')
  final int? noofPassengers;
  final String? name;
  final String? callSign;
  final String? tripNumber;
  final String? flightPurpose;
  final String? category;
  final String? registrationNumber;
  final String? fullName;
  final String? operatorname;
  final String? sourcepoint;
  final String? sourcepointwithicaoiata;
  final String? destinationpoint;
  final String? destinationpointwithicaoiata;
  final String? sourceCountry;
  final String? destinationCountry;
  final String? nextarrival;
  final String? nextarrivalLocal;
  final String? stayVal;
  @JsonKey(name: 'FBOName')
  final String? fBOName;
  @JsonKey(name: 'fBOFName')
  final String? fBOFName;
  final String? country;
  final String? baseAirport;
  final List<TripPobScheduleDetail>? pobLists;
  final int? crewCount;
  final int? passengerCount;

  TripPobSchedule({
    required this.tripScheduleId,
    required this.tripId,
    required this.tripsequenceNumber,
    this.eTa,
    this.eTD,
    this.eTATBA,
    this.eTDTBA,
    this.noofCrews,
    this.noofPassengers,
    this.name,
    this.callSign,
    this.tripNumber,
    this.flightPurpose,
    this.category,
    this.registrationNumber,
    this.fullName,
    this.operatorname,
    this.sourcepoint,
    this.sourcepointwithicaoiata,
    this.destinationpoint,
    this.destinationpointwithicaoiata,
    this.sourceCountry,
    this.destinationCountry,
    this.nextarrival,
    this.nextarrivalLocal,
    this.stayVal,
    this.fBOName,
    this.fBOFName,
    this.country,
    this.baseAirport,
    this.pobLists,
    this.crewCount,
    this.passengerCount,
  });

  TripPobSchedule copyWith({
    required int tripScheduleId,
    required int tripId,
    required int tripsequenceNumber,
    String? eTa,
    String? eTD,
    bool? eTATBA,
    bool? eTDTBA,
    int? noofCrews,
    int? noofPassengers,
    String? name,
    String? callSign,
    String? tripNumber,
    String? flightPurpose,
    String? category,
    String? registrationNumber,
    String? fullName,
    String? operatorname,
    String? sourcepoint,
    String? sourcepointwithicaoiata,
    String? destinationpoint,
    String? destinationpointwithicaoiata,
    String? sourceCountry,
    String? destinationCountry,
    String? nextarrival,
    String? nextarrivalLocal,
    String? stayVal,
    String? fBOName,
    String? fBOFName,
    String? country,
    String? baseAirport,
    List<TripPobScheduleDetail>? pobLists,
    int? crewCount,
    int? passengerCount,
  }) {
    return TripPobSchedule(
      tripScheduleId: tripScheduleId,
      tripId: tripId,
      tripsequenceNumber: tripsequenceNumber,
      eTa: eTa,
      eTD: eTD,
      eTATBA: eTATBA,
      eTDTBA: eTDTBA,
      noofCrews: noofCrews,
      noofPassengers: noofPassengers,
      name: name,
      callSign: callSign,
      tripNumber: tripNumber,
      flightPurpose: flightPurpose,
      category: category,
      registrationNumber: registrationNumber,
      fullName: fullName,
      operatorname: operatorname,
      sourcepoint: sourcepoint,
      sourcepointwithicaoiata: sourcepointwithicaoiata,
      destinationpoint: destinationpoint,
      destinationpointwithicaoiata: destinationpointwithicaoiata,
      sourceCountry: sourceCountry,
      destinationCountry: destinationCountry,
      nextarrival: nextarrival,
      nextarrivalLocal: nextarrivalLocal,
      stayVal: stayVal,
      fBOName: fBOName,
      fBOFName: fBOFName,
      country: country,
      baseAirport: baseAirport,
      pobLists: pobLists,
      crewCount: crewCount,
      passengerCount: passengerCount,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripPobSchedule].
  static TripPobSchedule fromJson(JsonMap json) =>
      _$TripPobScheduleFromJson(json);

  /// Converts this [TripPobSchedule] into a [JsonMap].
  JsonMap toJson() => _$TripPobScheduleToJson(this);

  @override
  List<Object?> get props => [
        tripScheduleId,
        tripId,
        tripsequenceNumber,
        eTa,
        eTD,
        eTATBA,
        eTDTBA,
        noofCrews,
        noofPassengers,
        callSign,
        tripNumber,
        flightPurpose,
        category,
        registrationNumber,
        fullName,
        operatorname,
        sourcepoint,
        sourcepointwithicaoiata,
        destinationpoint,
        destinationpointwithicaoiata,
        sourceCountry,
        destinationCountry,
        nextarrival,
        nextarrivalLocal,
        stayVal,
        fBOName,
        fBOFName,
        country,
        baseAirport,
        pobLists,
        crewCount,
        passengerCount,
      ];
}
