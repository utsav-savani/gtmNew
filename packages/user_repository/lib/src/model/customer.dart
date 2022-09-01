// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:user_repository/src/model/json_map.dart';

part 'customer.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Customer extends Equatable {
  final int customerId;
  final int organizationId;
  final String name;

  const Customer({
    required this.customerId,
    required this.organizationId,
    required this.name,
  });

  Customer copyWith({
    required int organizationId,
  }) {
    return Customer(
      customerId: customerId,
      organizationId: organizationId,
      name: name,
    );
  }

  /// Deserializes the given [JsonMap] into a [Customer].
  static Customer fromJson(JsonMap json) => _$CustomerFromJson(json);

  /// Converts this [Customer] into a [JsonMap].
  JsonMap toJson() => _$CustomerToJson(this);

  @override
  String toString() {
    return name;
  }

  @override
  List<Object?> get props => [customerId, organizationId, name];
}
