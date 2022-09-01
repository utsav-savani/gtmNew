// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sanction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sanction _$SanctionFromJson(Map<String, dynamic> json) => Sanction(
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String?,
      details:
          (json['details'] as List<dynamic>?)?.map((e) => e as String).toList(),
      adopter:
          (json['adopter'] as List<dynamic>?)?.map((e) => e as String).toList(),
      sancNone: json['sancNone'] as bool?,
      sancFlights: json['sancFlights'] as bool?,
      sancTravel: json['sancTravel'] as bool?,
      sancCargo: json['sancCargo'] as bool?,
      sancFinancial: json['sancFinancial'] as bool?,
      sancVesel: json['sancVesel'] as bool?,
      sancOther: json['sancOther'] as bool?,
      sancOtherNote: json['sancOtherNote'] as String?,
      sancNote: json['sancNote'] as String?,
    );

Map<String, dynamic> _$SanctionToJson(Sanction instance) => <String, dynamic>{
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'details': instance.details,
      'adopter': instance.adopter,
      'sancNone': instance.sancNone,
      'sancFlights': instance.sancFlights,
      'sancTravel': instance.sancTravel,
      'sancCargo': instance.sancCargo,
      'sancFinancial': instance.sancFinancial,
      'sancVesel': instance.sancVesel,
      'sancOther': instance.sancOther,
      'sancOtherNote': instance.sancOtherNote,
      'sancNote': instance.sancNote,
    };
