import 'package:http/http.dart' as http;
import 'package:trip_manager_repository/trip_manager_repository.dart';

class TripManagerDocumentsRepository {
  //MARK:- This is to return the trip manager dashboard documents list
  Future<TripDocumentFilterModel?> getTripDocumentFilter({
    required String guid,
  }) async {
    var _res;

    try {
      final url = Uri.parse(TripManagerUrls().getTripDocumentFilterData());

      final headers = await UserRepository().getHeaders();
      print("\n=================================");
      print("URL: $url \n Token: ${json.encode(headers)}");

      final _payload = json.encode({"guid": guid});
      print(_payload);
      print("=================================\n");
      await http
          .post(url, headers: headers, body: _payload)
          .then((value) async {
        print(value.body);
        if (value.statusCode == 200) {
          final Map<String, dynamic> response = jsonDecode(value.body);
          _res = TripDocumentFilterModel.fromJson(response);
        } else {
          print(value.body);
        }
      });
    } catch (e) {
      print(e.toString());
    }

    return _res;
  }

  //MARK:- This is to return the trip manager dashboard documents list
  Future<String?> getTripDocumentPDFURL({
    required TripManagerDocumentPayload payload,
  }) async {
    String? _res;

    try {
      final url = Uri.parse(TripManagerUrls().getTripBriedDataPDFUrl());

      final headers = await UserRepository().getHeaders();
      print("\n=================================");
      print("URL: $url \n Token: ${json.encode(headers)}");

      final _payload = json.encode(payload.toJson());
      print(_payload);
      print("=================================\n");
      await http
          .post(url, headers: headers, body: _payload)
          .then((value) async {
        print(value.body);
        if (value.statusCode == 200) {
          final Map<String, dynamic> response = jsonDecode(value.body);
          _res = response['data'];
        } else {
          print(value.body);
        }
      });
    } catch (e) {
      print(e.toString());
    }

    return _res;
  }
}
