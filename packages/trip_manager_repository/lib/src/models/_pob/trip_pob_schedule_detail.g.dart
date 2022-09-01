// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_pob_schedule_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripPobScheduleDetail _$TripPobScheduleDetailFromJson(
        Map<String, dynamic> json) =>
    TripPobScheduleDetail(
      baseAirport: json['baseAirport'] as String?,
      category: json['category'] as String?,
      countryofresidence: json['countryofresidence'] as String?,
      countryofresidencecode: json['countryofresidencecode'] as String?,
      destinationCountry: json['destinationCountry'] as String?,
      destinationpoint: json['destinationpoint'] as String?,
      destinationpointwithicaoiata:
          json['destinationpointwithicaoiata'] as String?,
      dob: json['dob'] as String?,
      eTA: json['ETA'] as String?,
      eTD: json['ETD'] as String?,
      fBOFName: json['FBOFName'] as String?,
      firstName: json['firstName'] as String?,
      flightPurpose: json['flightPurpose'] as String?,
      gender: json['gender'] as String?,
      lastName: json['lastName'] as String?,
      make: json['make'] as String?,
      nationality: json['nationality'] as String?,
      nationalityISOCode: json['nationalityISOCode'] as String?,
      nextarrival: json['nextarrival'] as String?,
      nextarrivalLocal: json['nextarrivalLocal'] as String?,
      noOfPassenger: json['noOfPassenger'] as int?,
      noOfcrew: json['noOfcrew'] as int?,
      operatorname: json['operatorname'] as String?,
      passportExpireDate: json['passportExpireDate'] as String?,
      passportId: json['passportId'] as int?,
      passportIssueDate: json['passportIssueDate'] as String?,
      passportNumber: json['passportNumber'] as String?,
      personId: json['personId'] as int?,
      personPassportDocumentId: json['personPassportDocumentId'] as int?,
      pref: json['pref'] as String?,
      registrationNumber: json['registrationNumber'] as String?,
      sourceCountry: json['sourceCountry'] as String?,
      sourcepoint: json['sourcepoint'] as String?,
      sourcepointwithicaoiata: json['sourcepointwithicaoiata'] as String?,
      stayVal: json['stayVal'] as String?,
      tripNumber: json['tripNumber'] as String?,
      tripScheduleId: json['tripScheduleId'] as int?,
      tripobId: json['tripobId'] as int?,
      tripsequenceNumber: json['tripsequenceNumber'] as int?,
      type: json['Type'] as String?,
    );

Map<String, dynamic> _$TripPobScheduleDetailToJson(
        TripPobScheduleDetail instance) =>
    <String, dynamic>{
      'tripNumber': instance.tripNumber,
      'tripobId': instance.tripobId,
      'personId': instance.personId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'dob': instance.dob,
      'gender': instance.gender,
      'countryofresidence': instance.countryofresidence,
      'countryofresidencecode': instance.countryofresidencecode,
      'ETA': instance.eTA,
      'nextarrival': instance.nextarrival,
      'nextarrivalLocal': instance.nextarrivalLocal,
      'stayVal': instance.stayVal,
      'ETD': instance.eTD,
      'flightPurpose': instance.flightPurpose,
      'category': instance.category,
      'registrationNumber': instance.registrationNumber,
      'make': instance.make,
      'operatorname': instance.operatorname,
      'FBOFName': instance.fBOFName,
      'sourcepoint': instance.sourcepoint,
      'destinationpoint': instance.destinationpoint,
      'sourcepointwithicaoiata': instance.sourcepointwithicaoiata,
      'destinationpointwithicaoiata': instance.destinationpointwithicaoiata,
      'Type': instance.type,
      'personPassportDocumentId': instance.personPassportDocumentId,
      'passportNumber': instance.passportNumber,
      'passportIssueDate': instance.passportIssueDate,
      'passportExpireDate': instance.passportExpireDate,
      'passportId': instance.passportId,
      'pref': instance.pref,
      'nationality': instance.nationality,
      'nationalityISOCode': instance.nationalityISOCode,
      'tripsequenceNumber': instance.tripsequenceNumber,
      'tripScheduleId': instance.tripScheduleId,
      'noOfcrew': instance.noOfcrew,
      'noOfPassenger': instance.noOfPassenger,
      'sourceCountry': instance.sourceCountry,
      'destinationCountry': instance.destinationCountry,
      'baseAirport': instance.baseAirport,
    };