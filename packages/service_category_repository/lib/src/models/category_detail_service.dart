import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:service_category_repository/config/typedef_json.dart';

part 'category_detail_service.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class CategoryDetailService extends Equatable {
  final int serviceId;
  final String name;
  final bool isDefault;

  const CategoryDetailService({
    required this.serviceId,
    required this.name,
    required this.isDefault,
  });

  CategoryDetailService copyWith({
    required int serviceId,
    required String name,
    required bool isDefault,
  }) {
    return CategoryDetailService(
      serviceId: serviceId,
      name: name,
      isDefault: isDefault,
    );
  }

  /// Deserializes the given [JsonMap] into a [CategoryDetailService].
  static CategoryDetailService fromJson(JsonMap json) =>
      _$CategoryDetailServiceFromJson(json);

  /// Converts this [Service] into a [JsonMap].
  JsonMap toJson() => _$CategoryDetailServiceToJson(this);

  @override
  List<Object?> get props => [serviceId, name, isDefault];
}
