import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vendor.g.dart';

@JsonSerializable(explicitToJson: true)
class Vendor {
  final int vendorId;
  final String name;
  final String? fullName;

  Vendor({required this.vendorId, required this.name, this.fullName});

  static Vendor fromJson(JsonMap json) => _$VendorFromJson(json);
  JsonMap toJson() => _$VendorToJson(this);
}
