import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:operator_repository/config/typedef_json.dart';

part 'operator.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Operator extends Equatable {
  final int aircraftId;
  final int customerId;
  final String customerName;

  const Operator({
    required this.aircraftId,
    required this.customerId,
    required this.customerName,
  });

  Operator copyWith({
    required int aircraftId,
    required int customerId,
    required String customerName,
  }) {
    return Operator(
      aircraftId: aircraftId,
      customerId: customerId,
      customerName: customerName,
    );
  }

  /// Deserializes the given [JsonMap] into a [Operator].
  static Operator fromJson(JsonMap json) => _$OperatorFromJson(json);

  /// Converts this [Operator] into a [JsonMap].
  JsonMap toJson() => _$OperatorToJson(this);

  @override
  List<Object?> get props => [aircraftId, customerId, customerName];
}
