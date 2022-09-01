import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_type.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class CustomerType extends Equatable {
  final int customerTypeId;
  final String customerType;

  const CustomerType({
    required this.customerTypeId,
    required this.customerType,
  });

  CustomerType copyWith({
    required int customerTypeId,
    required String customerType,
  }) {
    return CustomerType(
      customerTypeId: customerTypeId,
      customerType: customerType,
    );
  }

  /// Deserializes the given [JsonMap] into a [CustomerType].
  static CustomerType fromJson(JsonMap json) => _$CustomerTypeFromJson(json);

  /// Converts this [CustomerType] into a [JsonMap].
  JsonMap toJson() => _$CustomerTypeToJson(this);

  @override
  List<Object?> get props => [customerTypeId, customerType];
}
