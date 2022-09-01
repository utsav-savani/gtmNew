import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customers.g.dart';

@JsonSerializable(explicitToJson: true)
class Customers {
  final int customerId;
  final String name;

  Customers({required this.customerId, required this.name});
  static Customers fromJson(JsonMap json) => _$CustomersFromJson(json);
  JsonMap toJson() => _$CustomersToJson(this);
}
