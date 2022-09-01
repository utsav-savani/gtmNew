import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:json_annotation/json_annotation.dart';
part 'servicelist.g.dart';

@JsonSerializable(explicitToJson: true)
class ServiceList {
  final String category;
  final String service;
  final int serviceCategoryId;
  final String? serviceCode;
  final int serviceId;
  final String? note;

  ServiceList(
      {required this.category,
      required this.service,
      required this.serviceCategoryId,
      this.serviceCode,
      required this.serviceId,
      this.note});
  static ServiceList fromJson(JsonMap json) => _$ServiceListFromJson(json);
  JsonMap toJson() => _$ServiceListToJson(this);
}
