import 'package:flutter/material.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

part 'pob_customer.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class PobCustomer extends Equatable {
  final int? customerId;
  final int? organizationId;
  final String? customerName;

  const PobCustomer({
    this.customerId,
    this.organizationId,
    this.customerName,
  });

  PobCustomer copyWith({
    int? customerId,
    int? organizationId,
    String? customerName,
  }) {
    return PobCustomer(
      customerId: customerId,
      organizationId: organizationId,
      customerName: customerName,
    );
  }

  /// Deserializes the given [JsonMap] into a [PobCustomer].
  static PobCustomer fromJson(JsonMap json) => _$PobCustomerFromJson(json);

  /// Converts this [PobCustomer] into a [JsonMap].
  JsonMap toJson() => _$PobCustomerToJson(this);

  @override
  List<Object?> get props => [
        customerId,
        organizationId,
        customerName,
      ];
}
