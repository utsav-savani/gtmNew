import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:service_category_repository/service_category_repository.dart';
import 'package:service_category_repository/src/models/category_detail_service.dart';

part 'service_category.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class ServiceCategory extends Equatable {
  final int serviceCategoryId;
  final String name;
  final int? serviceCategoryParentId;
  @JsonKey(name: 'ChildServiceCategory')
  final List<ServiceCategory>? childServiceCategory;
  @JsonKey(name: 'Service')
  final List<CategoryDetailService>? service;

  const ServiceCategory({
    required this.serviceCategoryId,
    required this.name,
    this.serviceCategoryParentId,
    this.childServiceCategory,
    this.service,
  });

  ServiceCategory copyWith({
    required int serviceCategoryId,
    required String name,
    int? serviceCategoryParentId,
    List<ServiceCategory>? childServiceCategory,
    List<CategoryDetailService>? service,
  }) {
    return ServiceCategory(
      serviceCategoryId: serviceCategoryId,
      name: name,
      serviceCategoryParentId: serviceCategoryParentId,
      service: service??this.service,
      childServiceCategory: childServiceCategory,
    );
  }

  /// Deserializes the given [JsonMap] into a [ServiceCategory].
  static ServiceCategory fromJson(JsonMap json) =>
      _$ServiceCategoryFromJson(json);

  /// Converts this [ServiceCategory] into a [JsonMap].
  JsonMap toJson() => _$ServiceCategoryToJson(this);

  @override
  List<Object?> get props => [
        serviceCategoryId,
        name,
        serviceCategoryParentId,
        childServiceCategory,
        service,
      ];
}
