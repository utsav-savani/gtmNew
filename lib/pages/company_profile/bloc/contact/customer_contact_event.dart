part of 'customer_contact_bloc.dart';

class CustomerContactEvent extends Equatable {
  const CustomerContactEvent();

  @override
  List<Object> get props => [];
}

class FetchContactsEvent extends CustomerContactEvent {
  final int customerId;
  const FetchContactsEvent(this.customerId);
  @override
  List<Object> get props => [customerId];
}



// class FetchContactDetailsEvent extends CustomerContactEvent {
//   final int customerContactId;
//   const FetchContactDetailsEvent({required this.customerContactId});
//   @override
//   List<Object> get props => [customerContactId];
// }

// class UpdateContactDetailsEvent extends CustomerContactEvent {
//   final CreateCustomerContact contactDetails;
//   const UpdateContactDetailsEvent({required this.contactDetails});
//   @override
//   List<Object> get props => [contactDetails];
// }
