// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_checklist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripChecklist _$TripChecklistFromJson(Map<String, dynamic> json) =>
    TripChecklist(
      checkListsName: json['checkListsName'] as String?,
      checkListsNotes: json['checkListsNotes'] as String?,
    );

Map<String, dynamic> _$TripChecklistToJson(TripChecklist instance) =>
    <String, dynamic>{
      'checkListsName': instance.checkListsName,
      'checkListsNotes': instance.checkListsNotes,
    };
