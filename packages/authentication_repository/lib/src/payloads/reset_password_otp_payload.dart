import 'package:authentication_repository/src/json/json_convertible.dart';

class ResetPasswordOTPPayload implements JSONConvertible {
  final email;

  ResetPasswordOTPPayload({
    this.email,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "email": email.toString().trim(),
    };
  }
}
