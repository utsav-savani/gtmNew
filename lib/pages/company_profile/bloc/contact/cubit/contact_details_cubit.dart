import 'package:bloc/bloc.dart';
import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:equatable/equatable.dart';

part 'contact_details_state.dart';

class ContactDetailsCubit extends Cubit<ContactDetailsState> {
  final CompanyProfileRepository _companyProfileRepository;
  ContactDetailsCubit(
      {required CompanyProfileRepository companyProfileRepository})
      : _companyProfileRepository = companyProfileRepository,
        super(ContactDetailsInitial(status: ContactStatus.initial));

  List<String> contactTypes = [
    'Main',
    'Admin',
    'OPS',
    'Sales',
    'Accounts',
    'VR',
    'PR',
    'Personal',
    'Other'
  ];

  Future<void> loadContactBasicDetails(
      {required int customerId,
      required List<CustomerContact> contacts}) async {
    try {
      emit(state.copyWith(
          status: ContactStatus.loading,
          customers: state.customers,
          vendors: state.vendors,
          contacts: contacts,
          contactTypePriorityMap: state.contactTypePriorityMap));
      List<Customer> customers = await UserRepository().getCustomers();
      List<Vendor> vendors =
          await _companyProfileRepository.getVendorList(page: 0, limit: 10);

      // setting max priority upto 20
      Map<String, Set<int>> contactTypePriorityMap = {};
      for (int i = 0; i < contactTypes.length; i++) {
        contactTypePriorityMap.putIfAbsent(contactTypes[i].toLowerCase(),
            () => List.generate(20, (index) => index + 1).toSet());
      }
      for (int i = 0; i < contacts.length; i++) {
        Set<int> priorities =
            contactTypePriorityMap[contacts[i].contactType.toLowerCase()]!;
        priorities.remove(contacts[i].priority);
        contactTypePriorityMap[contacts[i].contactType.toLowerCase()] =
            priorities;
      }
      emit(state.copyWith(
          status: ContactStatus.success,
          customers: customers,
          vendors: vendors,
          contacts: contacts,
          contactTypePriorityMap: contactTypePriorityMap));
    } catch (e) {
      emit(state.copyWith(
          status: ContactStatus.failure,
          customers: state.customers,
          vendors: state.vendors,
          contacts: state.contacts,
          contactTypePriorityMap: state.contactTypePriorityMap));
    }
  }

// page value should be greater than 0
  Future<void> fetchNewCustomers(int page) async {
    try {
      emit(state.copyWith(
          status: ContactStatus.loading,
          customers: state.customers,
          vendors: state.vendors,
          contacts: state.contacts,
          contactTypePriorityMap: state.contactTypePriorityMap));

      List<Customer> customers =
          await _companyProfileRepository.getCustomerList(page: page);
      List<Customer> stateCustomers = state.customers;
      stateCustomers.addAll(customers);
      emit(state.copyWith(
          status: ContactStatus.success,
          customers: stateCustomers,
          vendors: state.vendors,
          contacts: state.contacts,
          contactTypePriorityMap: state.contactTypePriorityMap));
    } catch (e) {
      emit(state.copyWith(
          status: ContactStatus.failure,
          customers: state.customers,
          vendors: state.vendors,
          contacts: state.contacts,
          contactTypePriorityMap: state.contactTypePriorityMap));
    }
  }

// page value should be greater than 0
  Future<void> fetchNewVendors(int page) async {
    try {
      emit(state.copyWith(
          status: ContactStatus.loading,
          customers: state.customers,
          vendors: state.vendors,
          contacts: state.contacts,
          contactTypePriorityMap: state.contactTypePriorityMap));

      List<Vendor> vendors =
          await _companyProfileRepository.getVendorList(page: page);
      List<Vendor> stateVendors = state.vendors;
      stateVendors.addAll(vendors);
      emit(state.copyWith(
          status: ContactStatus.success,
          customers: state.customers,
          vendors: stateVendors,
          contacts: state.contacts,
          contactTypePriorityMap: state.contactTypePriorityMap));
    } catch (e) {
      emit(state.copyWith(
          status: ContactStatus.failure,
          customers: state.customers,
          vendors: state.vendors,
          contacts: state.contacts,
          contactTypePriorityMap: state.contactTypePriorityMap));
    }
  }

  Future<void> getContactDetails(int customerContactId) async {
    emit(state.copyWith(
        status: ContactStatus.initial,
        customers: state.customers,
        vendors: state.vendors,
        contacts: state.contacts,
        contactTypePriorityMap: state.contactTypePriorityMap));
    try {
      emit(state.copyWith(
          status: ContactStatus.loading,
          customers: state.customers,
          vendors: state.vendors,
          contacts: state.contacts,
          contactTypePriorityMap: state.contactTypePriorityMap));
      CustomerContact? contactDetail =
          await _companyProfileRepository.getCustomerContact(customerContactId);
      if (contactDetail != null) {
        CreateCustomerContact contactDetails = transforResponse(contactDetail);
        emit(state.copyWith(
            status: ContactStatus.success,
            customers: state.customers,
            vendors: state.vendors,
            contacts: state.contacts,
            contactTypePriorityMap: state.contactTypePriorityMap,
            contactDetail: contactDetails));
      } else {
        emit(state.copyWith(
            status: ContactStatus.failure,
            customers: state.customers,
            vendors: state.vendors,
            contacts: state.contacts,
            contactTypePriorityMap: state.contactTypePriorityMap));
      }
    } catch (e) {
      emit(state.copyWith(
          status: ContactStatus.failure,
          customers: state.customers,
          vendors: state.vendors,
          contacts: state.contacts,
          contactTypePriorityMap: state.contactTypePriorityMap));
    }
  }

// Pass the customerId in CreateCustomerContact object.
  Future<void> createContactDetails(
      CreateCustomerContact contactDetails) async {
    emit(state.copyWith(
        status: ContactStatus.initial,
        customers: state.customers,
        vendors: state.vendors,
        contacts: state.contacts,
        contactTypePriorityMap: state.contactTypePriorityMap));
    try {
      emit(state.copyWith(
          status: ContactStatus.loading,
          customers: state.customers,
          vendors: state.vendors,
          contacts: state.contacts,
          contactTypePriorityMap: state.contactTypePriorityMap));
      CustomerContact? res =
          await _companyProfileRepository.createCustomerContact(contactDetails);
      if (res != null) {
        emit(state.copyWith(
            contactDetail: transforResponse(res),
            status: ContactStatus.success,
            customers: state.customers,
            vendors: state.vendors,
            contacts: state.contacts,
            contactTypePriorityMap: state.contactTypePriorityMap));
      }
    } catch (e) {
      emit(state.copyWith(
          status: ContactStatus.failure,
          customers: state.customers,
          vendors: state.vendors,
          contacts: state.contacts,
          contactTypePriorityMap: state.contactTypePriorityMap));
    }
  }

// Pass the customerContactId in CreateCustomerContact object.
  Future<void> updateContactDetails(
      CreateCustomerContact contactDetails) async {
    emit(state.copyWith(
        status: ContactStatus.initial,
        customers: state.customers,
        vendors: state.vendors,
        contacts: state.contacts,
        contactTypePriorityMap: state.contactTypePriorityMap));
    try {
      emit(state.copyWith(
          status: ContactStatus.loading,
          customers: state.customers,
          vendors: state.vendors,
          contacts: state.contacts,
          contactTypePriorityMap: state.contactTypePriorityMap));
      CustomerContact? res =
          await _companyProfileRepository.updateCustomerContact(contactDetails);
      if (res != null) {
        emit(state.copyWith(
            contactDetail: transforResponse(res),
            status: ContactStatus.success,
            customers: state.customers,
            vendors: state.vendors,
            contacts: state.contacts,
            contactTypePriorityMap: state.contactTypePriorityMap));
      }
    } catch (e) {
      emit(state.copyWith(
          status: ContactStatus.failure,
          customers: state.customers,
          vendors: state.vendors,
          contacts: state.contacts,
          contactTypePriorityMap: state.contactTypePriorityMap));
    }
  }

  CreateCustomerContact transforResponse(CustomerContact contactDetail) {
    Set<int> customerIds = {};
    Set<int> vendorIds = {};
    List<ContactInfo> contactInfos = [];
    if (contactDetail.linkedCustomers != null &&
        contactDetail.linkedCustomers!.isNotEmpty) {
      for (int i = 0; i < contactDetail.linkedCustomers!.length; i++) {
        customerIds.add(contactDetail.linkedCustomers![i].customerId);
      }
    }
    if (contactDetail.linkedVendors != null &&
        contactDetail.linkedVendors!.isNotEmpty) {
      for (int i = 0; i < contactDetail.linkedVendors!.length; i++) {
        vendorIds.add(contactDetail.linkedVendors![i].vendorId);
      }
    }
    Map<int, Map<int, List<String>>> typeContactIdContentMap = {};
    Map<int, List<String>> purposeContactTypeIdMap = {};
    if (contactDetail.callRecords.isNotEmpty) {
      Map<int, List<CallRecord>> recordContactTypeIdMap = {};
      for (int i = 0; i < contactDetail.callRecords.length; i++) {
        purposeContactTypeIdMap.putIfAbsent(
            contactDetail.callRecords[i].customerContactTypeId,
            () => contactDetail.callRecords[i].purpose ?? []);
        if (recordContactTypeIdMap
            .containsKey(contactDetail.callRecords[i].customerContactTypeId)) {
          List<CallRecord> temp = recordContactTypeIdMap[
              contactDetail.callRecords[i].customerContactTypeId]!;
          temp.add(contactDetail.callRecords[i]);
          recordContactTypeIdMap[
              contactDetail.callRecords[i].customerContactTypeId] = temp;
        } else {
          recordContactTypeIdMap.putIfAbsent(
              contactDetail.callRecords[i].customerContactTypeId,
              () => [contactDetail.callRecords[i]]);
        }
      }
      if (recordContactTypeIdMap.isNotEmpty) {
        List<int> typeIds = recordContactTypeIdMap.keys.toList();
        typeIds.sort();
        for (int i = 0; i < typeIds.length; i++) {
          List<CallRecord> records = recordContactTypeIdMap[typeIds[i]]!;
          Map<int, List<String>> tempContent = {};
          for (int j = 0; j < records.length; j++) {
            if (tempContent.containsKey(records[j].contactCategoryId)) {
              List<String> temp = tempContent[records[j].contactCategoryId]!;
              temp.add(records[j].info);
              tempContent[records[i].contactCategoryId] = temp;
            } else {
              tempContent.putIfAbsent(
                  records[j].contactCategoryId, () => [records[j].info]);
            }
          }
          typeContactIdContentMap.putIfAbsent(typeIds[i], () => tempContent);
        }
      }
    }
    if (typeContactIdContentMap.isNotEmpty) {
      List<int> typeIds = typeContactIdContentMap.keys.toList();
      typeIds.sort();
      for (int i = 0; i < typeIds.length; i++) {
        ContactInfo info = ContactInfo();
        info.category = [];
        info.purposes = purposeContactTypeIdMap[typeIds[i]];
        List<int> contactIds =
            typeContactIdContentMap[typeIds[i]]!.keys.toList();
        contactIds.sort();
        for (int j = 0; j < contactIds.length; j++) {
          info.category!.add(ContactCategory(
              contactcategoryType: contactIds[j],
              content: typeContactIdContentMap[typeIds[i]]![contactIds[j]]));
        }
        contactInfos.add(info);
      }
    }
    return CreateCustomerContact(
        name: contactDetail.name,
        priority: contactDetail.priority,
        customercontactId: contactDetail.customercontactId,
        customerId: contactDetail.customerId,
        contactType: contactDetail.contactType,
        vendorIds: vendorIds.toList(),
        customerIds: customerIds.toList(),
        contactInfos: contactInfos);
  }
}
