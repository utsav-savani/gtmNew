// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_statistic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripStatistic _$TripStatisticFromJson(Map<String, dynamic> json) =>
    TripStatistic(
      total: json['total'] as int,
      completed: json['completed'] as int,
      inProgress: json['inProgress'] as int,
      draft: json['draft'] as int,
      cancelled: json['cancelled'] as int,
    );

Map<String, dynamic> _$TripStatisticToJson(TripStatistic instance) =>
    <String, dynamic>{
      'total': instance.total,
      'completed': instance.completed,
      'inProgress': instance.inProgress,
      'draft': instance.draft,
      'cancelled': instance.cancelled,
    };
