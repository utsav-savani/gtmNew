import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:equatable/equatable.dart';

part 'customer_contact_event.dart';
part 'customer_contact_state.dart';

class CustomerContactBloc
    extends Bloc<CustomerContactEvent, CustomerContactState> {
  final CompanyProfileRepository _companyProfileRepository;
  CustomerContactBloc(
      {required CompanyProfileRepository companyProfileRepository})
      : _companyProfileRepository = companyProfileRepository,
        super(CustomerContactInitial()) {
    on<FetchContactsEvent>(_fetchCustomerContacts);
  }

  FutureOr<void> _fetchCustomerContacts(
      FetchContactsEvent event, Emitter<CustomerContactState> emit) async {
    emit(state.copyWith(status: ContactListStatus.initial, contacts: []));
    try {
      emit(state.copyWith(status: ContactListStatus.loading, contacts: []));
      List<CustomerContact> _response =
          await _companyProfileRepository.getCustomerContacts(event.customerId);
      emit(state.copyWith(
          status: ContactListStatus.success, contacts: _response));
    } catch (e) {
      emit(state.copyWith(status: ContactListStatus.failure, contacts: []));
    }
  }
}
