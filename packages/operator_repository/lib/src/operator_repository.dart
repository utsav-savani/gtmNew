import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:operator_repository/operator_repository.dart';
import 'package:operator_repository/src/constants/operator_urls.dart';
import 'package:user_repository/user_repository.dart';

class OperatorRepository {
  OperatorRepository();

  //MARK:- This is to return the list of operators
  Future<List<Operator>> getOperators({required String aircraftId}) async {
    List<Operator> _response = [];
    try {
      final url = Uri.parse(OperatorUrls().getOperatorUrl(aircraftId));

      final headers = await UserRepository().getHeaders();
      print("URL: $url \n Token: ${json.encode(headers)}");

      await http.get(url, headers: headers).then((response) async {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final responseData = jsonResponse['data'] as List;
          print(responseData);
          responseData
              .map((data) => _response.add(Operator.fromJson(data)))
              .toList();
        }
      });
      return _response;
    } catch (e) {
      print(e);
      return _response;
    }
  }
}
