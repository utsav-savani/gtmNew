import 'package:flutter_dotenv/flutter_dotenv.dart';

class OperatorUrls {
  //MARK:- This is to get the Base url from env
  String _baseURL = dotenv.env['TMSAPIBASEURL']!;

  getOperatorUrl(String id) =>
      "$_baseURL/aircraft/getOperatorBasedOnAircraftID/$id?device=mobile";
}
