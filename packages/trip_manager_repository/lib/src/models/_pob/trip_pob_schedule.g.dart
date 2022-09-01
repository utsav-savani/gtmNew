// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_pob_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripPobSchedule _$TripPobScheduleFromJson(Map<String, dynamic> json) =>
    TripPobSchedule(
      tripScheduleId: json['tripScheduleId'] as int,
      tripId: json['tripId'] as int,
      tripsequenceNumber: json['tripsequenceNumber'] as int,
      eTa: json['ETA'] as String?,
      eTD: json['ETD'] as String?,
      eTATBA: json['ETATBA'] as bool?,
      eTDTBA: json['ETDTBA'] as bool?,
      noofCrews: json['NoofCrews'] as int?,
      noofPassengers: json['NoofPassengers'] as int?,
      name: json['name'] as String?,
      callSign: json['callSign'] as String?,
      tripNumber: json['tripNumber'] as String?,
      flightPurpose: json['flightPurpose'] as String?,
      category: json['category'] as String?,
      registrationNumber: json['registrationNumber'] as String?,
      fullName: json['fullName'] as String?,
      operatorname: json['operatorname'] as String?,
      sourcepoint: json['sourcepoint'] as String?,
      sourcepointwithicaoiata: json['sourcepointwithicaoiata'] as String?,
      destinationpoint: json['destinationpoint'] as String?,
      destinationpointwithicaoiata:
          json['destinationpointwithicaoiata'] as String?,
      sourceCountry: json['sourceCountry'] as String?,
      destinationCountry: json['destinationCountry'] as String?,
      nextarrival: json['nextarrival'] as String?,
      nextarrivalLocal: json['nextarrivalLocal'] as String?,
      stayVal: json['stayVal'] as String?,
      fBOName: json['FBOName'] as String?,
      fBOFName: json['fBOFName'] as String?,
      country: json['country'] as String?,
      baseAirport: json['baseAirport'] as String?,
      pobLists: (json['pobLists'] as List<dynamic>?)
          ?.map(
              (e) => TripPobScheduleDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      crewCount: json['crewCount'] as int?,
      passengerCount: json['passengerCount'] as int?,
    );

Map<String, dynamic> _$TripPobScheduleToJson(TripPobSchedule instance) =>
    <String, dynamic>{
      'tripScheduleId': instance.tripScheduleId,
      'tripId': instance.tripId,
      'tripsequenceNumber': instance.tripsequenceNumber,
      'ETA': instance.eTa,
      'ETD': instance.eTD,
      'ETATBA': instance.eTATBA,
      'ETDTBA': instance.eTDTBA,
      'NoofCrews': instance.noofCrews,
      'NoofPassengers': instance.noofPassengers,
      'name': instance.name,
      'callSign': instance.callSign,
      'tripNumber': instance.tripNumber,
      'flightPurpose': instance.flightPurpose,
      'category': instance.category,
      'registrationNumber': instance.registrationNumber,
      'fullName': instance.fullName,
      'operatorname': instance.operatorname,
      'sourcepoint': instance.sourcepoint,
      'sourcepointwithicaoiata': instance.sourcepointwithicaoiata,
      'destinationpoint': instance.destinationpoint,
      'destinationpointwithicaoiata': instance.destinationpointwithicaoiata,
      'sourceCountry': instance.sourceCountry,
      'destinationCountry': instance.destinationCountry,
      'nextarrival': instance.nextarrival,
      'nextarrivalLocal': instance.nextarrivalLocal,
      'stayVal': instance.stayVal,
      'FBOName': instance.fBOName,
      'fBOFName': instance.fBOFName,
      'country': instance.country,
      'baseAirport': instance.baseAirport,
      'pobLists': instance.pobLists?.map((e) => e.toJson()).toList(),
      'crewCount': instance.crewCount,
      'passengerCount': instance.passengerCount,
    };
