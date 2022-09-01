import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:company_profile_repository/src/models/customerContactTypeInfo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_contact.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomerContact {
  final int customercontactId;
  final int? customerId;
  final int priority;
  @JsonKey(name: 'Name')
  final String name;
  final String contactType;
  @JsonKey(name: 'CustomerContactTypeInfo')
  final List<CustomerContactTypeInfo> customerContactTypeInfo;
  final List<CallRecord> callRecords;
  final List<Customers>? linkedCustomers;
  final List<Vendor>? linkedVendors;

  CustomerContact(
      {required this.customercontactId,
      this.customerId,
      required this.name,
      required this.contactType,
      required this.customerContactTypeInfo,
      required this.callRecords,
      required this.priority,
      this.linkedCustomers,
      this.linkedVendors});

  static CustomerContact fromJson(JsonMap json) =>
      _$CustomerContactFromJson(json);
  JsonMap toJson() => _$CustomerContactToJson(this);
}
