import 'dart:developer';

import 'package:country_repository/country_repository.dart';
import 'package:http/http.dart' as http;

class CountryRepository {
  CountryRepository();
  List<Sanction> _sanctionsRes = [];

  //MARK:- This is to return the countries list
  Future<List<Country>> getCountries() async {
    List<Country> _country = [];
    try {
      final url = Uri.parse(CountryUrls().getCountriesUrl());

      final headers = await UserRepository().getHeaders();
      print("URL: $url \n Token: ${json.encode(headers)}");

      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final responseData = jsonResponse['data'] as List;
          for (var item in responseData) {
            _country.add(Country.fromJson(item));
          }
        }
      });
      return _country;
    } catch (e) {
      print(e);
      return _country;
    }
  }

  //MARK:- This is to return the country details general info
  Future<Country?> getGeneralInfo(int countryId) async {
    Country? _countryRes = null;
    try {
      final url = Uri.parse(CountryUrls().getCountryDetailsUrl(countryId));

      final headers = await UserRepository().getHeaders();
      print("URL: $url \n Token: ${json.encode(headers)}");

      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          print(jsonResponse);
          final responseData = jsonResponse['data'] as Map<String, dynamic>;
          _countryRes = Country.fromJson(responseData);
          print(_countryRes);
        }
      });
    } catch (e) {
      print(e);
    }
    return _countryRes;
  }

  //MARK:- This is to return the country details health info
  Future<Health?> getHealthInfo(int countryId) async {
    Health? _healthRes = null;
    try {
      final url = Uri.parse(CountryUrls().getCountryHealthDetailsUrl(countryId));

      final headers = await UserRepository().getHeaders();
      print("URL: $url \n Token: ${json.encode(headers)}");

      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          print(jsonResponse);
          final responseData = jsonResponse['data'] as Map<String, dynamic>;
          _healthRes = Health.fromJson(responseData);
          print(_healthRes);
        }
      });
    } catch (e) {
      print(e);
    }
    return _healthRes;
  }

  //MARK:- This is to return the country details health info
  Future<List<PassportVisa>?> getPassportVisaInfo(int countryId) async {
    List<PassportVisa> _passportVisaRes = [];
    try {
      final url = Uri.parse(CountryUrls().getCountryPassportVisaDetails(countryId));

      final headers = await UserRepository().getHeaders();
      print("URL: $url \n Token: ${json.encode(headers)}");

      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          print(jsonResponse);
          final responseData = jsonResponse['data'] as List;
          for (var item in responseData) {
            _passportVisaRes.add(PassportVisa.fromJson(item));
          }
          return _passportVisaRes;
        }
      });
    } catch (e) {
      print(e);
    }
    return _passportVisaRes;
  }

  //MARK:- This is to return the country details Sanctions info
  Future<List<Sanction>>? getSanctions(int countryId) async {
    if (_sanctionsRes.isNotEmpty) {
      _sanctionsRes.clear();
    }
    try {
      final url = Uri.parse(CountryUrls().getSantionDetailsUrl(countryId));

      final headers = await UserRepository().getHeaders();
      print("URL: $url \n Token: ${json.encode(headers)}");

      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          print(jsonResponse);
          final responseData = jsonResponse['data'] as List;
          for (var item in responseData) {
            _sanctionsRes.add(Sanction.fromJson(item));
          }
          return _sanctionsRes;
        }
      });
    } catch (e) {
      print(e);
    }
    return _sanctionsRes;
  }

//

  //MARK:- This is to return the country details Sanctions info with search
  Future<List<Sanction>>? getSanctionSearch(String searchText, bool clear) async {
    List<Sanction> filteredSanctions = [];
    try {
      /* List<Sanction> filteredSanctions = _sanctionsRes.where((mainElement) {
        mainElement.details!.where((element) => {
          return  element.toLowerCase().contains(searchText);
        });
      }).toList(); */

      // if (filteredSanctions.isNotEmpty || clear) {
      //   filteredSanctions.clear();
      //   filteredSanctions.addAll(_sanctionsRes);
      // } else {
      //   for (var sanction in _sanctionsRes) {
      //     var item = sanction.details!.where((element) => element.contains(searchText));
      //     if (item.isNotEmpty) {
      //       filteredSanctions.add(sanction);
      //     }
      //   }
      // }
    } catch (e) {
      log(e.toString());
    }
    return filteredSanctions;
  }

  //MARK:- This is to return the country details flight requirements info
  Future<List<FlightRequirement>>? getFlightRequirements(int countryId) async {
    List<FlightRequirement> _flightRequirementsRes = [];
    try {
      final url = Uri.parse(CountryUrls().getRequirementsUrl(countryId));

      final headers = await UserRepository().getHeaders();
      print("URL: $url \n Token: ${json.encode(headers)}");

      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          print(jsonResponse);
          final responseData = jsonResponse['data'] as List;
          for (var item in responseData) {
            _flightRequirementsRes.add(FlightRequirement.fromJson(item));
          }
          return _flightRequirementsRes;
        }
      });
    } catch (e) {
      print(e);
    }
    return _flightRequirementsRes;
  }

  //MARK:- This is to return the country alert details
  Future<List<Alert>>? getAlerts(int countryId) async {
    List<Alert> _alertsRes = [];
    try {
      final url = Uri.parse(CountryUrls().getAlertsUrl(countryId));

      final headers = await UserRepository().getHeaders();
      print("URL: $url \n Token: ${json.encode(headers)}");

      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          print(jsonResponse);
          final responseData = jsonResponse as List;
          for (var item in responseData) {
            _alertsRes.add(Alert.fromJson(item));
          }
          return _alertsRes;
        }
      });
    } catch (e) {
      print(e);
    }
    return _alertsRes;
  }
}


 // if (clear) {
      //   filteredSanctions = [];
      // } else if (searchText.isNotEmpty) {
      //   for (var sanctions in _sanctionsRes) {
      //     for (var item in sanctions.details!) {
      //       if (item.contains(searchText)) {
      //         filteredSanctions.add(sanctions);
      //       } else {
      //         filteredSanctions.clear();
      //         filteredSanctions.addAll(_sanctionsRes);
      //       }
      //     }
      //   }
      // } else if (searchText.isEmpty) {
      //   filteredSanctions.addAll(_sanctionsRes);
      // }