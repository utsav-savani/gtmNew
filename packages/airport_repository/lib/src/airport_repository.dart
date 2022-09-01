import 'package:airport_repository/airport_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'constants/string_constant.dart';

class AirportRepository {
  AirportRepository();

  AirportsListFilter _filter = AirportsListFilter();

  int page = 0;
  int limit = 100;
  bool next = false;

  void setLimit(String limit) => _filter.setLimit(limit);
  void setPage(String page) => _filter.setPage(page);
  void setSearch(String search) => _filter.setSearch(search);
  void setCountryId(String countryId) => _filter.setCountryId(countryId);

  //MARK:- This is to return the trip manager dashboard list
  Future<List<Airport>> getAirportsWeb(search) async {
    setPage("1");
    setLimit("10");
    setSearch(search);
    List<Airport> _airportRes = [];
    try {
      final url = Uri.parse(AirportUrls().getAirportUrl(_filter));

      final headers = await UserRepository().getHeaders();
      print("URL: $url \n Token: ${json.encode(headers)}");

      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final responseData = jsonResponse['data'] as List;
          print(responseData);
          for (var item in responseData) {
            _airportRes.add(Airport.fromJson(item));
          }
        }
      });
      return _airportRes;
    } catch (e) {
      print(e);
      return _airportRes;
    }
  }

  Future<List<Airport>> getAirports({AirportsListFilter? filter}) async {
    if (next) {}
    List<Airport> _airportRes = [];
    try {
      if (filter != null) _filter = filter;
      final url = Uri.parse(AirportUrls().getAirportUrl(_filter));

      final headers = await UserRepository().getHeaders();
      print("URL: $url \n Token: ${json.encode(headers)}");

      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final responseData = jsonResponse['data'] as List;
          print(responseData);
          for (var item in responseData) {
            _airportRes.add(Airport.fromJson(item));
          }
        }
      });
      return _airportRes;
    } catch (e) {
      print(e);
      return _airportRes;
    }
  }

  Future<List<Airport>> getAirportsPagination(bool forward) async {
    if (forward) {
      if (page == 0) {
        limit = 100;
        page = limit + page;
      }
    } else {
      if (page != 0) {
        limit = 100;
        page = limit - page;
      } else {
        /// might be the first time loading
        page = 0;
        limit = 100;
      }
    }
    _filter.setLimit(limit.toString());
    _filter.setPage(page.toString());
    List<Airport> _airportRes = [];

    try {
      _filter.setPage(page.toString());
      _filter.setLimit(limit.toString());

      final url = Uri.parse(AirportUrls().getAirportUrl(_filter));
      final headers = await UserRepository().getHeaders();
      print("URL: $url \n Token: ${json.encode(headers)}");

      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final responseData = jsonResponse['data'] as List;
          //print(responseData);
          for (var item in responseData) {
            _airportRes.add(Airport.fromJson(item));
          }
        }
      });
      return _airportRes;
    } catch (e) {
      debugPrint(e.toString());
      // print(e);
      return _airportRes;
    }
  }

  Future<AirportGeneralInfo> getAirportGeneralInfo(int airportId) async {
    AirportGeneralInfo? _airportGeneralInfo;
    try {
      final url = Uri.parse(AirportUrls().getAirportGeneralInfoUrl(airportId));

      final headers = await UserRepository().getHeaders();
      // print("URL: $url \n Token: ${json.encode(headers)}");

      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == statusCode) {
          final jsonResponse = json.decode(response.body);
          final responseData = jsonResponse;
          _airportGeneralInfo = AirportGeneralInfo.fromJson(responseData);
          //   print(responseData);
          // for (var item in responseData) {
          //   _airportRes.add(Airport.fromJson(item));
          // }
        }
      });
      return _airportGeneralInfo!;
    } catch (e) {
      debugPrint(e.toString());
      return _airportGeneralInfo!;
    }
  }

  Future<List<Airport>> getAirportByName(String airportName) async {
    List<Airport> airportList = [];
    try {
      final url = Uri.parse(AirportUrls().getAirportByName(airportName));

      final headers = await UserRepository().getHeaders();
      // print("URL: $url \n Token: ${json.encode(headers)}");

      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == statusCode) {
          final jsonResponse = json.decode(response.body);
          final responseData = jsonResponse['data'] as List;
          //print(responseData);
          for (var item in responseData) {
            airportList.add(Airport.fromJson(item));
          }
        }
      });
      return airportList;
    } catch (e) {
      debugPrint(e.toString());
      return airportList;
    }
  }
}
