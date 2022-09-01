import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:gtm/theme/app_theme.dart';
import 'package:gtm/app/bloc/app_bloc.dart';
import 'package:gtm/config/router/routes.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

/// configure the main theme here and return a redirect child based on authentication
class SplashScreen extends StatefulWidget {
  ///
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    GoRouter goRoutes(AppBloc bloc) {
      return GoRouter(
        debugLogDiagnostics: true,
        routes: routes,
        redirect: (state) {
          final isLoggedIn = bloc.state.status == AppStatus.authenticated;
          final isOnLogin = state.location == Routes.login;
          final isOnSignUp = state.location == Routes.register;
          debugPrint("Is Logged in: $isLoggedIn");
          debugPrint("Is Signup: $isOnSignUp");

          if (!isOnLogin && !isOnSignUp && !isLoggedIn) {
            return Routes.login;
          }
          if ((isOnLogin || isOnSignUp) && isLoggedIn){
            return Routes.dashboard;
          }
          return null;
        },
        refreshListenable: GoRouterRefreshStream(
          context.read<AppBloc>().stream,
        ),
      );
    }

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          routeInformationParser: goRoutes(context.read<AppBloc>()).routeInformationParser,
          routerDelegate: goRoutes(context.read<AppBloc>()).routerDelegate,
          title: 'GTM | Global Trip Manager',
          debugShowCheckedModeBanner: false,
          theme: AppTheme().defaultTheme(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}
