import 'dart:async';

import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:airport_repository/airport_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:country_repository/country_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flight_category_repository/flight_category_repository.dart';
import 'package:flight_purpose_repository/flight_purpose_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gtm/_shared/_common/locales.dart';
import 'package:gtm/_shared/helpers/app_helper.dart';
import 'package:gtm/app/app_bloc_observer.dart';
import 'package:gtm/app/view/app_view.dart';
import 'package:gtm/pages/home/cubit/tab_cubit/tab_repository.dart';
import 'package:operator_repository/operator_repository.dart';
import 'package:people_repository/people_repository.dart';
import 'package:service_category_repository/service_category_repository.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

///runs the desired environment from the main_dev, main_prod, main_stage
void bootstrap() {
  FlutterError.onError = (FlutterErrorDetails details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  final TripManagerRepository _tripManagerRepository = TripManagerRepository();
  final AircraftRepository _aircraftRepository = AircraftRepository();
  final CountryRepository _countryRepository = CountryRepository();
  final AirportRepository _airportRepository = AirportRepository();
  final PaginatedAirportRepository _paginatedAirportRepository =
      PaginatedAirportRepository();
  final FlightCategoryRepository _flightCategoryRepository =
      FlightCategoryRepository();
  final OperatorRepository _operatorRepository = OperatorRepository();
  final UserRepository _userRepository = UserRepository();
  final FlightPurposeRepository _flightPurposeRepository =
      FlightPurposeRepository();
  final TabRepository _tabRepository = TabRepository();
  final TripManagerDocumentsRepository _tripManagerDocumentsRepository =
      TripManagerDocumentsRepository();
  final TripManagerPOBRepository _tripManagerPOBRepository =
      TripManagerPOBRepository();
  final TripManagerScheduleRepository _tripManagerScheduleRepository =
      TripManagerScheduleRepository();
  final TripManagerServiceRepository _tripManagerServiceRepository =
      TripManagerServiceRepository();
  final CompanyProfileRepository _companyProfileRepository =
      CompanyProfileRepository();
  final PeopleRepository _peopleRepository = PeopleRepository();
  final ServiceCategoryRepository _serviceCategoryRepository =
      ServiceCategoryRepository();

  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await EasyLocalization.ensureInitialized();

      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color(0xffF6F6F6), // status bar color
        statusBarBrightness: Brightness.light, //status bar brightness
        statusBarIconBrightness: Brightness.light, //status barIcon Brightness
      ));

      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
      await dotenv.load(fileName: ".env");
      String accessToken = await AppHelper().getAccessToken();

      await BlocOverrides.runZoned(
        () async {
          runApp(
            EasyLocalization(
              supportedLocales: supportedLocales,
              path: 'assets/translations',
              fallbackLocale: const Locale('en', 'US'),
              child: App(
                accessToken: accessToken,
                authenticationRepository: _authenticationRepository,
                tripManagerRepository: _tripManagerRepository,
                aircraftRepository: _aircraftRepository,
                countryRepository: _countryRepository,
                airportRepository: _airportRepository,
                paginatedAirportRepository: _paginatedAirportRepository,
                flightCategoryRepository: _flightCategoryRepository,
                operatorRepository: _operatorRepository,
                userRepository: _userRepository,
                flightPurposeRepository: _flightPurposeRepository,
                tabRepository: _tabRepository,
                tripManagerScheduleRepository: _tripManagerScheduleRepository,
                tripManagerDocumentRepository: _tripManagerDocumentsRepository,
                tripManagerPOBRepository: _tripManagerPOBRepository,
                tripManagerServiceRepository: _tripManagerServiceRepository,
                companyProfileRepository: _companyProfileRepository,
                peopleRepository: _peopleRepository,
                serviceCategoriesRepository: _serviceCategoryRepository,
              ),
            ),
          );
        },
        blocObserver: AppBlocObserver(),
      );
    },
    (Object error, StackTrace stackTrace) => log(
      error.toString(),
      stackTrace: stackTrace,
    ),
  );
}
