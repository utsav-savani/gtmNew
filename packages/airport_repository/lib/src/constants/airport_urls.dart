import 'package:airport_repository/src/constants/airports_list_filter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AirportUrls {
  //MARK:- This is to get the Base url from env
  String _baseURL = dotenv.env['TMSAPIBASEURL']!;

  getAirportUrl(AirportsListFilter filter) {
    var url = "$_baseURL/airport/gtm/all?device=mobile";
    var _limit = "20";
    if (filter.limit() != null) _limit = filter.limit().toString();
    var _page = "0";
    print("------- ${filter.page()}");
    if (filter.page() != null) _page = filter.page().toString();
    url += "&limit=$_limit";
    url += "&page=$_page";
    if (filter.search() != null) url += "&filter=${filter.search()}";
    if (filter.countryId() != null) url += "&countryId=${filter.countryId()}";
    return url;
  }

  getAirportUrlPagination(AirportsListFilter filter) {
    // https://qa-tmseapi.uas.aero/api/airport/gtm/all?page=0&&limit=2&&sort=&&filter=
    var url =
        "$_baseURL/airport/gtm/all?page='$filter.page'&&limit='$filter.limit'&&device=mobile";
    if (filter.limit() != null) url += "&limit=${filter.limit() ?? 20}";
    if (filter.page() != null) url += "&page=${filter.page() ?? 1}";
    if (filter.search() != null) url += "&filter=${filter.search()}";
    if (filter.countryId() != null) url += "&countryId=${filter.countryId()}";
    return url;
  }

  getAirportGeneralInfoUrl(int airportId) {
    // https://qa-tmseapi.uas.aero/api/airport/gtm/1
    var url = "$_baseURL/airport/gtm/$airportId";
    // if (filter.limit() != null) url += "&limit=${filter.limit() ?? 20}";
    return url;
  }

  getAirportByName(String airportName) {
    // https://qa-tmseapi.uas.aero/api/airport/gtm/1
    var url = "$_baseURL/airport/gtm/?all$airportName";
    // if (filter.limit() != null) url += "&limit=${filter.limit() ?? 20}";
    return url;
  }
}
