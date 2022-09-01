import 'package:flutter_dotenv/flutter_dotenv.dart';

class CountryUrls {
  //MARK:- This is to get the Base url from env
  String _baseURL = dotenv.env['TMSAPIBASEURL']!;

  //MARK:- This is to get the countries list URL
  getCountriesUrl() => "$_baseURL/country/gtm/all";

  //MARK:- This is to get the countries details URL
  getCountryDetailsUrl(int countryId) => "$_baseURL/country/gtm/$countryId";

  //MARK:- This is to get the countries health details URL
  getCountryHealthDetailsUrl(int countryId) =>
      "$_baseURL/country/countryHealth/$countryId";

  //MARK:- This is to get the countries passport visa details URL
  getCountryPassportVisaDetails(int countryId) =>
      "$_baseURL/country/countryPassportVisa/$countryId";

  //MARK:- This is to get the countries sanction visa details URL
  getSantionDetailsUrl(int countryId) =>
      "$_baseURL/country/gtm/sanctions/$countryId";

  //MARK:- This is to get the countries requirements details URL
  getRequirementsUrl(int countryId) =>
      "$_baseURL/country/gtm/requirements/$countryId";

  //MARK:- This is to get the countries alert details URL
  getAlertsUrl(int countryId) => "$_baseURL/country/getCountryAlert/$countryId";
}
