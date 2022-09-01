part of 'customer_contact_bloc.dart';

enum ContactListStatus { initial, loading, success, failure }

class CustomerContactState extends Equatable {
  final ContactListStatus status;
  final List<CustomerContact> contacts;
  const CustomerContactState({
    required this.status,
    required this.contacts,
  });

  CustomerContactState copyWith(
      {required ContactListStatus status,
      required List<CustomerContact> contacts,
      bool? isEditScreenOpened}) {
    return CustomerContactState(
      status: status,
      contacts: contacts,
    );
  }

  @override
  List<Object> get props => [status, contacts];
}

class CustomerContactInitial extends CustomerContactState {
  CustomerContactInitial()
      : super(status: ContactListStatus.initial, contacts: []);
}
