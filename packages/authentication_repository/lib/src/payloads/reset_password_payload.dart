import 'package:authentication_repository/src/json/json_convertible.dart';

class ResetPasswordPayload implements JSONConvertible {
  final password;
  final confirm_password;

  ResetPasswordPayload({
    this.password,
    this.confirm_password,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "password": password,
      "confirm_password": confirm_password,
    };
  }
}
