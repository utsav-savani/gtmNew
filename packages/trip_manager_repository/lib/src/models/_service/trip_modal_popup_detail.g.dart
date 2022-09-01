// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_modal_popup_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripModalPopupDetail _$TripModalPopupDetailFromJson(
        Map<String, dynamic> json) =>
    TripModalPopupDetail(
      service: json['service'] as String?,
      serviceStatus: json['serviceStatus'] as String?,
      scheduleStatus: json['scheduleStatus'] as String?,
      through: json['through'] as String?,
      payment: json['payment'] as String?,
      checklist: (json['checklist'] as List<dynamic>?)
          ?.map((e) => TripChecklist.fromJson(e as Map<String, dynamic>))
          .toList(),
      sequence: json['sequence'] == null
          ? null
          : Sequence.fromJson(json['sequence'] as Map<String, dynamic>),
      vendors: (json['vendors'] as List<dynamic>?)
          ?.map((e) => Vendor.fromJson(e as Map<String, dynamic>))
          .toList(),
      fields: (json['fields'] as List<dynamic>?)
          ?.map((e) => TripServiceField.fromJson(e as Map<String, dynamic>))
          .toList(),
      historyLog: (json['historyLog'] as List<dynamic>?)
          ?.map((e) => HistoryLog.fromJson(e as Map<String, dynamic>))
          .toList(),
      taskMemos: (json['taskMemos'] as List<dynamic>?)
          ?.map((e) => TaskMemo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TripModalPopupDetailToJson(
        TripModalPopupDetail instance) =>
    <String, dynamic>{
      'service': instance.service,
      'serviceStatus': instance.serviceStatus,
      'scheduleStatus': instance.scheduleStatus,
      'through': instance.through,
      'payment': instance.payment,
      'sequence': instance.sequence?.toJson(),
      'vendors': instance.vendors?.map((e) => e.toJson()).toList(),
      'taskMemos': instance.taskMemos?.map((e) => e.toJson()).toList(),
      'historyLog': instance.historyLog?.map((e) => e.toJson()).toList(),
      'fields': instance.fields?.map((e) => e.toJson()).toList(),
      'checklist': instance.checklist?.map((e) => e.toJson()).toList(),
    };
