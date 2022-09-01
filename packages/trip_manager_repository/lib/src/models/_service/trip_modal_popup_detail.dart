import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trip_manager_repository/config/typedef_json.dart';
import 'package:trip_manager_repository/src/models/_service/_partials/history_log.dart';
import 'package:trip_manager_repository/src/models/_service/_partials/sequence.dart';
import 'package:trip_manager_repository/src/models/_service/_partials/task_memo.dart';
import 'package:trip_manager_repository/src/models/_service/_partials/trip_checklist.dart';
import 'package:trip_manager_repository/src/models/_service/_partials/trip_service_field.dart';
import 'package:trip_manager_repository/src/models/_service/_partials/vendor.dart';

part 'trip_modal_popup_detail.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class TripModalPopupDetail extends Equatable {
  final String? service;
  final String? serviceStatus;
  final String? scheduleStatus;
  final String? through;
  final String? payment;
  final Sequence? sequence;
  final List<Vendor>? vendors;
  final List<TaskMemo>? taskMemos;
  final List<HistoryLog>? historyLog;
  final List<TripServiceField>? fields;
  final List<TripChecklist>? checklist;

  const TripModalPopupDetail({
    this.service,
    this.serviceStatus,
    this.scheduleStatus,
    this.through,
    this.payment,
    this.checklist,
    this.sequence,
    this.vendors,
    this.fields,
    this.historyLog,
    this.taskMemos,
  });

  TripModalPopupDetail copyWith({
    String? service,
    String? serviceStatus,
    String? scheduleStatus,
    String? through,
    String? payment,
    Sequence? sequence,
    List<Vendor>? vendors,
    List<TaskMemo>? taskMemos,
    List<HistoryLog>? historyLog,
    List<TripServiceField>? fields,
    List<TripChecklist>? checklist,
  }) {
    return TripModalPopupDetail(
      service: service,
      serviceStatus: serviceStatus,
      sequence: sequence,
      scheduleStatus: scheduleStatus,
      through: through,
      payment: payment,
      checklist: checklist,
      vendors: vendors,
      taskMemos: taskMemos,
      historyLog: historyLog,
      fields: fields,
    );
  }

  /// Deserializes the given [JsonMap] into a [TripModalPopupDetail].
  static TripModalPopupDetail fromJson(JsonMap json) =>
      _$TripModalPopupDetailFromJson(json);

  /// Converts this [TripModalPopupDetail] into a [JsonMap].
  JsonMap toJson() => _$TripModalPopupDetailToJson(this);

  @override
  List<Object?> get props => [
        service,
        serviceStatus,
        sequence,
        scheduleStatus,
        through,
        payment,
        checklist,
        vendors,
        taskMemos,
        historyLog,
        fields,
      ];
}
