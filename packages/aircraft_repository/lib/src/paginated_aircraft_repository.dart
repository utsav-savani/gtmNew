// import 'package:aircraft_repository/aircraft_repository.dart';
// import 'package:http/http.dart' as http;

// class PaginatedAircraftRepository {
//   PaginatedAircraftRepository();

//   AircraftFilter _filter = AircraftFilter();

//   void setLimit(String limit) => _filter.setLimit(limit);
//   void setPage(String page) => _filter.setPage(page);

//   //MARK:- This is to return the aircraft list
//   Future<AircraftData> getPaginatedAircraft() async {
//     try {
//       final url = Uri.parse(AircraftUrls().getAircraftUrl(_filter));
//       print(url);

//       final userToken = await UserRepository().getToken();
//       AircraftData _response = AircraftData(0, []);
//       await http.get(url, headers: {
//         'Authorization': "Bearer $userToken",
//       }).then((response) async {
//         if (response.statusCode == 200) {
//           final jsonResponse = json.decode(response.body);
//           final responseData = jsonResponse['data'] as List;
//           List<Aircraft> aircraft = [];
//           responseData
//               .map((data) => aircraft.add(Aircraft.fromJson(data)))
//               .toList();
//           _response = AircraftData(jsonResponse['total'], aircraft);
//         }
//       });
//       return _response;
//     } catch (e) {
//       print(e);
//       AircraftData _response = AircraftData(0, []);
//       return _response;
//     }
//   }

//   //MARK:- This is to return the aircraft list
//   // Future<List<Aircraft>> getSubAircraft() async {
//   //   final url = Uri.parse(AircraftUrls().getSubAircraftsUrl(_filter));
//   //   print(url);

//   //   final userToken = await UserRepository().getToken();
//   //   List<Aircraft> _response = [];
//   //   try {
//   //     await http.get(url, headers: {
//   //       'Authorization': "Bearer $userToken",
//   //     }).then((response) async {
//   //       if (response.statusCode == 200) {
//   //         final jsonResponse = json.decode(response.body);
//   //         final responseData = jsonResponse['data'] as List;
//   //         responseData
//   //             .map((data) => _response.add(Aircraft.fromJson(data)))
//   //             .toList();
//   //       }
//   //     });
//   //   } catch (e) {
//   //     print(e);
//   //   }
//   //   return _response;
//   // }
// }
