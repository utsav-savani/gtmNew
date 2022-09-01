// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_memo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskMemo _$TaskMemoFromJson(Map<String, dynamic> json) => TaskMemo(
      name: json['name'] as String?,
      date: json['date'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$TaskMemoToJson(TaskMemo instance) => <String, dynamic>{
      'name': instance.name,
      'date': instance.date,
      'note': instance.note,
    };
