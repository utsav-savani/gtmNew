import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:company_profile_repository/config/typedef_json.dart';
import 'package:json_annotation/json_annotation.dart';
part 'create_customer_contact.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateCustomerContact {
  final int? customerId;
  final int? customercontactId;
  @JsonKey(name: 'Name')
  String name;
  @JsonKey(name: 'Priority')
  int priority;
  String contactType;
  @JsonKey(name: 'ContactInfo')
  List<ContactInfo> contactInfos;
  @JsonKey(name: 'CustomerIds')
  List<int>? customerIds;
  @JsonKey(name: 'VendorIds')
  List<int>? vendorIds;
  CreateCustomerContact(
      {this.customerId,
      this.customercontactId,
      required this.name,
      required this.priority,
      required this.contactType,
      required this.contactInfos,
      this.customerIds,
      this.vendorIds});

  static CreateCustomerContact fromJson(JsonMap json) =>
      _$CreateCustomerContactFromJson(json);
  JsonMap toJson() => _$CreateCustomerContactToJson(this);
}
