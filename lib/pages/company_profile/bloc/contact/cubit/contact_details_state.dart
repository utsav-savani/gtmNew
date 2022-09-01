part of 'contact_details_cubit.dart';

enum ContactStatus { initial, loading, success, failure }

class ContactDetailsState extends Equatable {
  final ContactStatus status;
  final CreateCustomerContact? contactDetails;
  List<Customer> customers = [];
  List<Vendor> vendors = [];
  List<CustomerContact> contacts = [];
  Map<String, Set<int>> contactTypePriorityMap = {};

  ContactDetailsState(
      {required this.status,
      this.contactDetails,
      required this.customers,
      required this.vendors,
      required this.contacts,
      required this.contactTypePriorityMap});

  ContactDetailsState copyWith(
      {required ContactStatus status,
      CreateCustomerContact? contactDetail,
      required List<Customer> customers,
      required List<Vendor> vendors,
      required List<CustomerContact> contacts,
      required Map<String, Set<int>> contactTypePriorityMap}) {
    return ContactDetailsState(
        status: status,
        contactDetails: contactDetail,
        customers: customers,
        vendors: vendors,
        contacts: contacts,
        contactTypePriorityMap: contactTypePriorityMap);
  }

  @override
  List<Object?> get props => [
        status,
        customers,
        vendors,
        contacts,
        contactTypePriorityMap,
        contactDetails
      ];
}

class ContactDetailsInitial extends ContactDetailsState {
  ContactDetailsInitial({required ContactStatus status})
      : super(
            status: status,
            contacts: [],
            vendors: [],
            customers: [],
            contactTypePriorityMap: {});
}
