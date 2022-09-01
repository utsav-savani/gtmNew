import 'package:flutter_dotenv/flutter_dotenv.dart';

class FlightCategoryUrls {
  //MARK:- This is to get the Base url from env
  String _baseURL = dotenv.env['TMSAPIBASEURL']!;

  getFlightCategoriesUrls(id) =>
      "$_baseURL/customer/getFlightCategoriesDropDown/$id?device=mobile";
}
