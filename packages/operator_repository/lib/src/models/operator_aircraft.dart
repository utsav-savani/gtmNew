import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:operator_repository/config/typedef_json.dart';

part 'operator_aircraft.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class OperatorAircraft extends Equatable {
  final int aircraftId;
  final int customerId;

  const OperatorAircraft({
    required this.aircraftId,
    required this.customerId,
  });

  OperatorAircraft copyWith({
    required int aircraftId,
    required int customerId,
  }) {
    return OperatorAircraft(
      aircraftId: aircraftId,
      customerId: customerId,
    );
  }

  /// Deserializes the given [JsonMap] into a [OperatorAircraft].
  static OperatorAircraft fromJson(JsonMap json) => _$OperatorAircraftFromJson(json);

  /// Converts this [OperatorAircraft] into a [JsonMap].
  JsonMap toJson() => _$OperatorAircraftToJson(this);

  @override
  List<Object?> get props => [
        aircraftId,
        customerId,
      ];
}
