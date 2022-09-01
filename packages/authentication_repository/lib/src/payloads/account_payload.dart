import 'package:authentication_repository/src/json/json_convertible.dart';

class AccountPayload implements JSONConvertible {
  final firstName;
  final companyName;
  final emailAddress;
  final location;

  AccountPayload({
    this.firstName,
    this.companyName,
    this.emailAddress,
    this.location,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "companyName": companyName,
      "emailAddress": emailAddress,
      "location": location,
    };
  }
}
