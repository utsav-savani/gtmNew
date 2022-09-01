import 'package:flutter_dotenv/flutter_dotenv.dart';

class ServiceCategoryUrls {
  //MARK:- This is to get the Base url from env
  String _baseURL = dotenv.env['TMSAPIBASEURL']!;

  getServiceCategoriesUrl() => "$_baseURL/service/gtm/all";
}
