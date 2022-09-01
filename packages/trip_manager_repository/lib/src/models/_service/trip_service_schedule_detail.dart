// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:trip_manager_repository/config/typedef_json.dart';

// part 'trip_service_schedule_detail.g.dart';

// @immutable
// @JsonSerializable(explicitToJson: true)
// class TripService extends Equatable {
//   final int serviceId;
//   final String name;

//   const TripService({
//     required this.serviceId,
//     required this.name,
//   });

//   TripService copyWith({
//     required String name,
//     required int serviceId,
//   }) {
//     return TripService(
//       name: name,
//       serviceId: serviceId,
//     );
//   }

//   /// Deserializes the given [JsonMap] into a [TripService].
//   static TripService fromJson(JsonMap json) => _$TripServiceFromJson(json);

//   /// Converts this [TripService] into a [JsonMap].
//   JsonMap toJson() => _$TripServiceToJson(this);

//   @override
//   List<Object?> get props => [name, serviceId];
// }
