import 'package:flutter_dotenv/flutter_dotenv.dart';

class FlightPurposeUrls {
  //MARK:- This is to get the Base url from env
  String _baseURL = dotenv.env['TMSAPIBASEURL']!;

  getFlightPurposesUrls() => "$_baseURL/organization/flightPurpuses/all";
}
