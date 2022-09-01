import 'dart:convert';

import 'package:flight_purpose_repository/flight_purpose_repository.dart';
import 'package:flight_purpose_repository/src/constants/flight_purpose_urls.dart';
import 'package:http/http.dart' as http;
import 'package:user_repository/user_repository.dart';

class FlightPurposeRepository {
  FlightPurposeRepository();

  //MARK:- This is to return the purposes list
  Future<List<FlightPurpose>> getFlightPurposesData() async {
    try {
      final url = Uri.parse(FlightPurposeUrls().getFlightPurposesUrls());
      print("Flight Purpose URL: $url");

      final headers = await UserRepository().getHeaders();
      List<FlightPurpose> _response = [];
      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final responseData = json.decode(response.body) as List;
          responseData
              .map((data) => _response.add(FlightPurpose.fromJson(data)))
              .toList();
          print(responseData);
        }
      });
      return _response;
    } catch (e) {
      print(e);
      List<FlightPurpose> _response = [];
      return _response;
    }
  }
}
