import 'package:aircraft_repository/src/filters/aircraft_filter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AircraftUrls {
  //MARK:- This is to get the Base url from env
  String _baseURL = dotenv.env['TMSAPIBASEURL']!;

  //MARK:- This is to get the Aircrafts list
  getAircraftUrl(AircraftFilter filter) {
    var query = "?device=mobile";
    if (filter.page() != null) query += "&page=${filter.page()}";
    if (filter.limit() != null) query += "&limit=${filter.limit()}";
    if (filter.search() != null) query += "&filter=${filter.search()}";
    if (filter.customerId() != null)
      query += "&customerId=${filter.customerId()}";
    return "$_baseURL/aircraft/allDropDown$query";
  }

  getDetailedAircraftUrl() {
    return "$_baseURL/customer/aircraft/all";
  }

  getAircraftDetailUrl(int aircraftId) {
    return "$_baseURL/aircraft/$aircraftId";
  }

  createAircraftUrl() {
    return "$_baseURL/aircraft";
  }

  updateAircraftUrl(int aircraftId) {
    return "$_baseURL/aircraft/$aircraftId";
  }

  //MARK:- This is to get the Sub Aircrafts list
  getSubAircraftsUrl(
    AircraftFilter filter, {
    required int aircraftId,
    required int customerId,
  }) {
    var query = "?device=mobile";
    if (filter.page() != null) query += "&page=${filter.page()}";
    if (filter.limit() != null) query += "&limit=${filter.limit()}";
    return "$_baseURL/aircraft/getSubAircrafts/$aircraftId/$customerId$query";
  }

  getCustomerListUrl(int page, int limit) {
    return "$_baseURL/customer/allDropDown?page=$page&&limit=$limit";
  }

  getOperatorListUrl(int page, int limit) {
    return "$_baseURL/customer/allOperatorDropDown?page=$page&&limit=$limit";
  }

  getCountryListUrl() {
    return "$_baseURL/checklist/checklistsCountries";
  }

  getAircraftTypeListUrl() {
    return "$_baseURL/aircraft/aircraftType/all";
  }

  getCountryAirportListUrl(int countryId, int page) {
    return "$_baseURL/airport/allDropDown?countryId=$countryId&&page=$page&&limit=10";
  }

  getAllDocumentsUrl(int aircraftId) {
    return "$_baseURL/aircraft/document/all/$aircraftId";
  }

  getDoctypeUrl() {
    return "$_baseURL/documents/docTypes?model=Aircraft";
  }

  uploadDocumentUrl() {
    return "$_baseURL/aircraft/document/upload";
  }

  updateDocumentUrl(int documentId) {
    return "$_baseURL/aircraft/document/update/$documentId";
  }

  getAircraftTripsUrls() {
    return "$_baseURL/trip/trip/getTripsBasedOnTeam";
  }

  getDownloadDocumentUrl(int docId) {
    return '$_baseURL/aircraft/document/$docId';
  }
}
