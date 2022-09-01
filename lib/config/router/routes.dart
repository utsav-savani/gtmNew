import 'package:go_router/go_router.dart';
import 'package:gtm/pages/authentication/forgot_password_screen.dart';
import 'package:gtm/pages/authentication/login_screen.dart';
import 'package:gtm/pages/authentication/otp_verfication_screen.dart';
import 'package:gtm/pages/authentication/register_screen.dart';
import 'package:gtm/pages/authentication/reset_password.dart';
import 'package:gtm/pages/authentication/welcome.dart';
import 'package:gtm/pages/home/view/home_page.dart';
import 'package:gtm/pages/manage_trip/view/manage_trip.dart';

class Routes {
  static const secureRedirectionKey = 'redirectionKey';
  static const welcome = '/welcome';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot_password';
  static const otpVerify = forgotPassword + '/otp_verify';
  static const resetPassword = forgotPassword + '/reset_password';
  static const dashboard = '/dashboard';
  static const tripDetailsScreen = '/trip_detail_screen';
}

final routes = [
  GoRoute(
    path: Routes.welcome,
    builder: (context, state) => const WelcomeScreen(),
  ),
  GoRoute(
    path: Routes.login,
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: Routes.register,
    name: Routes.register,
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
    path: Routes.forgotPassword,
    builder: (context, state) => const ForgotPasswordScreen(),
  ),
  GoRoute(
    path: Routes.otpVerify,
    builder: (context, state) {
      String email = state.extra as String;
      return OTPVerificationScreen(email: email);
    },
  ),
  GoRoute(
    path: Routes.resetPassword,
    builder: (context, state) {
      ResetPasswordScreenParams params =
          state.extra as ResetPasswordScreenParams;
      return ResetPasswordScreen(params: params);
    },
  ),
  GoRoute(
    path: Routes.dashboard,
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: Routes.tripDetailsScreen,
    builder: (context, state) {
      String guid = state.extra as String;
      return ManageTrip(
        guid: guid,
      );
    },
  ),
];
