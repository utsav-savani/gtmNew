import 'dart:convert';

import 'package:airport_repository/src/constants/airport_urls.dart';
import 'package:airport_repository/src/constants/airports_list_filter.dart';
import 'package:airport_repository/src/models/airport.dart';
import 'package:airport_repository/src/models/airport_data.dart';
import 'package:http/http.dart' as http;
import 'package:user_repository/user_repository.dart';

class PaginatedAirportRepository {
  PaginatedAirportRepository();

  AirportsListFilter _filter = AirportsListFilter();
  void setLimit(String limit) => _filter.setLimit(limit);
  void setPage(String page) => _filter.setPage(page);
  void setSearch(String search) => _filter.setSearch(search);
  void setCountryId(String? countryId) => _filter.setCountryId(countryId);

  Future<AirportData> getPaginatedAirports() async {
    try {
      final userToken = await UserRepository().getToken();
      final url = Uri.parse(AirportUrls().getAirportUrl(_filter));
      print(url);
      print(userToken);

      AirportData _response = AirportData(0, []);
      await http.get(url, headers: {'Authorization': "Bearer $userToken"}).then(
          (response) async {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final responseData = jsonResponse['data'] as List;
          print(responseData);
          final List<Airport> airports = [];
          responseData
              .map((data) => airports.add(Airport.fromJson(data)))
              .toList();
          _response = AirportData(jsonResponse['total'], airports);
        }
      });
      return _response;
    } catch (e) {
      print(e);
      AirportData _response = AirportData(0, []);
      return _response;
    }
  }
}
