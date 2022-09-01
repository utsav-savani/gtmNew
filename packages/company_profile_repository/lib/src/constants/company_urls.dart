import 'package:company_profile_repository/src/filters/company_filter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CompanyUrls {
  //MARK:- This is to get the Base url from env
  String _baseURL = dotenv.env['TMSAPIBASEURL']!;

  //MARK:- This is to get the Company Profile list
  getCustomerUrl(CompanyFilter filter) {
    var query = "?device=mobile";
    if (filter.page() != null) query += "&page=${filter.page()}";
    if (filter.limit() != null) query += "&limit=${filter.limit()}";
    if (filter.search() != null) query += "&filter=${filter.search()}";
    if (filter.customerIdList() != null)
      query += "&customerId=${filter.customerIdList()}";
    return "$_baseURL/customer/gtm/all$query";
  }

  updateCustomerUrl(int customerId) {
    return "$_baseURL/customer/gtm/$customerId";
  }

  getAllFlightCategoriesUrl() {
    return '$_baseURL/organization/flightCategory/all';
  }

  getCustomerFlightCategoryUrl(int customerId) {
    return "$_baseURL/customer/fc/all/$customerId";
  }

  updateCustomerFlightcategoryUrl() {
    return "$_baseURL/customer/fc/";
  }

  getCustomerContactsUrl(int customerId) {
    return "$_baseURL/customer/contact/getContacts/$customerId";
  }

  createCustomerContactUrl(int customerId) {
    return "$_baseURL/customer/contact/addContact/$customerId";
  }

  getCustomerContactUrl(int customerContactId) {
    return '$_baseURL/customer/contact/getContactInfo/$customerContactId';
  }

  updateCustomerContactUrl(int customercontactId) {
    return "$_baseURL/customer/contact/editContact/$customercontactId";
  }

  getCustomerListUrl(int page, int limit) {
    return "$_baseURL/customer/allDropDown?page=$page&&limit=$limit";
  }

  getVendorListUrl(int page, int limit) {
    return "$_baseURL/vendor/allDropDown?page=$page&&limit=$limit";
  }

  getCustomerNotesUrl(int customerId) {
    return "$_baseURL/customer/note/all/$customerId";
  }

  addCustomerNoteUrl() {
    return "$_baseURL/customer/note";
  }

  updateCustomerNoteUrl(int customerOperationalNoteId) {
    return "$_baseURL/customer/note/all/$customerOperationalNoteId";
  }

  deleteCustomerNoteUrl(int customerOperationalNoteId) {
    return "$_baseURL/customer/note/$customerOperationalNoteId";
  }

  getServiceListUrl() {
    return "$_baseURL/checklist/checklistServices";
  }

  uploadDocumentUrl() {
    return "$_baseURL/customer/document/upload";
  }

  updateDocumentUrl(int documentId) {
    return "$_baseURL/customer/document/update/$documentId";
  }

  getAllDocumentsUrl(int customerId) {
    return "$_baseURL/customer/document/all/$customerId";
  }

  getDocTypesUrl() {
    return "$_baseURL/documents/docTypes?model=Customer";
  }

  addcustomerdetailsvalidateUrl() {
    return "$_baseURL/customer/contact/addcustomerdetailsvalidate";
  }

  getCustomerPrefrenceUrl(int customerId, int page) {
    return "$_baseURL/customer/preference/all/$customerId?page=$page&&limit=100&&sort=&&colId=";
  }

  getDownloadDocumentUrl(int docId) {
    return '$_baseURL/customer/document/$docId';
  }
}
