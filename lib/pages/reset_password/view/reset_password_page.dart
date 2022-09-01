import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gtm/pages/authentication/forgot_password_screen.dart';

import 'web/w_reset_password_page.dart';

/// Login Page for the user with Microsoft B2C too
class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: ResetPasswordPage());

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ResetPasswordPage());
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const Scaffold(body: WResetPasswordPage());
    } else {
      return const Scaffold(
        resizeToAvoidBottomInset: false,
        body: ForgotPasswordScreen(),
      );
    }
  }
}
