import 'package:trip_manager_repository/json/json_convertible.dart';

class TripLookUpPayload implements JSONConvertible {
  final guid;
  final customercontactId;

  const TripLookUpPayload({
    this.guid,
    this.customercontactId,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "guid": guid,
      "customercontactId": customercontactId,
    };
  }
}
