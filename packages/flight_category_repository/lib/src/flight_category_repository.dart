import 'dart:convert';

import 'package:flight_category_repository/flight_category_repository.dart';
import 'package:flight_category_repository/src/constants/flight_category_urls.dart';
import 'package:http/http.dart' as http;
import 'package:user_repository/user_repository.dart';

class FlightCategoryRepository {
  FlightCategoryRepository();

  //MARK:- This is to return the categories list
  Future<List<FlightCategory>> getFlightCategories({
    required String customerId,
  }) async {
    List<FlightCategory> _response = [];
    try {
      final url =
          Uri.parse(FlightCategoryUrls().getFlightCategoriesUrls(customerId));

      final headers = await UserRepository().getHeaders();
      print("URL: $url \n Token: ${json.encode(headers)}");

      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final responseData = json.decode(response.body) as List;
          responseData
              .map((data) => _response.add(FlightCategory.fromJson(data)))
              .toList();
          print(responseData);
        }
      });
      return _response;
    } catch (e) {
      print(e);
      return _response;
    }
  }
}
