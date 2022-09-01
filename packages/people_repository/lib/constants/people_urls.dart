import 'package:flutter_dotenv/flutter_dotenv.dart';

class PeopleUrls {
  //MARK:- This is to get the Base url from env
  String _baseURL = dotenv.env['TMSAPIBASEURL']!;

  getPeopleUrl() => "$_baseURL/customer/person/";

  getCustomerListUrl(int page, int limit) {
    return "$_baseURL/customer/allDropDown?page=$page&&limit=$limit";
  }

  validatePersonUrl() {
    return '$_baseURL/customer/person/validatePerson';
  }

  validateLicenceUrl() {
    return '$_baseURL/customer/person/validateLicencenumber';
  }

  fetchPersonDetailsUrl(String guid) {
    return '$_baseURL/customer/person/$guid';
  }

  updatePersonDetailsUrl(bool isPassenger) {
    String type = 'crew';
    if (isPassenger) {
      type = 'passenger';
    }
    return '$_baseURL/customer/$type';
  }

  fetchCityListUrl() {
    return '$_baseURL/airport/cities';
  }

  uploadPassportUrl() {
    return '$_baseURL/customer/document/crew/passport/upload';
  }

  updatePassportUrl(int passportId) {
    return '$_baseURL/customer/document/person/update/$passportId';
  }

  uploadVisaUrl() {
    return '$_baseURL/customer/document/crew/visa/upload';
  }

  updateVisaUrl(int visaId) {
    return '$_baseURL/customer/document/person/update/$visaId';
  }
}
