import 'package:authentication_repository/src/json/json_convertible.dart';

class ResetPasswordVerifyOTPPayload implements JSONConvertible {
  final email;
  final otp;

  ResetPasswordVerifyOTPPayload({
    this.email,
    this.otp,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "token": otp,
    };
  }
}
