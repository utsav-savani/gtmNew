import 'package:aircraft_repository/config/typedef_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customers.g.dart';

// had to create a different class because is some case name is coming null in response
@JsonSerializable(explicitToJson: true)
class Customers {
  final int customerId;
  final String? name;
  final String? customerName;
  final int? organizationId;

  Customers(
      {required this.customerId,
      this.name,
      this.organizationId,
      this.customerName});
  static Customers fromJson(JsonMap json) => _$CustomersFromJson(json);

  /// Converts this [AircraftDetails] into a [JsonMap].
  JsonMap toJson() => _$CustomersToJson(this);
}
