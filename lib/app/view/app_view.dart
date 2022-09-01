import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:airport_repository/airport_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:country_repository/country_repository.dart';
import 'package:flight_category_repository/flight_category_repository.dart';
import 'package:flight_purpose_repository/flight_purpose_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:gtm/app/bloc/app_bloc.dart';
import 'package:gtm/config/router/routes.dart';
import 'package:gtm/generated/l10n.dart';
import 'package:gtm/pages/aircraft/bloc/aircraft/aircraft_bloc.dart';
import 'package:gtm/pages/aircraft/bloc/aircraft/cubit/aircraft_detail_cubit.dart';
import 'package:gtm/pages/aircraft/bloc/document/document_bloc.dart';
import 'package:gtm/pages/aircraft/bloc/trip/trips_bloc.dart';
import 'package:gtm/pages/airport/bloc/airport_bloc.dart';
import 'package:gtm/pages/airport/bloc/paginated_airport_bloc.dart';
import 'package:gtm/pages/airport/cubit/airport_cubit.dart';
import 'package:gtm/pages/authentication/auth_info.dart';
import 'package:gtm/pages/company_profile/bloc/contact/cubit/contact_details_cubit.dart';
import 'package:gtm/pages/company_profile/bloc/contact/customer_contact_bloc.dart';
import 'package:gtm/pages/company_profile/bloc/document/customer_document_bloc.dart';
import 'package:gtm/pages/company_profile/bloc/notes/customer_notes_bloc.dart';
import 'package:gtm/pages/company_profile/bloc/prefrence/prefrence_bloc.dart';
import 'package:gtm/pages/company_profile/cubit/company_flight_category_cubit.dart';
import 'package:gtm/pages/company_profile/cubit/company_profile_cubit.dart';
import 'package:gtm/pages/countries/bloc/alerts/country_alerts_bloc.dart';
import 'package:gtm/pages/countries/bloc/country_list/country_bloc.dart';
import 'package:gtm/pages/countries/bloc/flight_requirements/country_flight_requirements_bloc.dart';
import 'package:gtm/pages/countries/bloc/general_info/country_general_info_bloc.dart';
import 'package:gtm/pages/countries/bloc/sanctions/country_sanctions_bloc.dart';
import 'package:gtm/pages/countries/countries.dart';
import 'package:gtm/pages/countries/cubit/country_cubit/country_cubit_cubit.dart';
import 'package:gtm/pages/flight_category/bloc/flight_category_bloc.dart';
import 'package:gtm/pages/home/cubit/tab_cubit/tab_repository.dart';
import 'package:gtm/pages/home/dashboard/bloc/trips/trip_bloc.dart';
import 'package:gtm/pages/home/dashboard/bloc/trips/trip_statistics_bloc.dart';
import 'package:gtm/pages/home/dashboard/dashboard_event.dart';
import 'package:gtm/pages/home/home.dart';
import 'package:gtm/pages/login/login.dart';
import 'package:gtm/pages/manage_trip/bloc/_schedule/trip_schedule_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/document/documents_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/document/documents_pdf_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/edit_delete_pob_sequence/edit_delete_pob_sequence_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_details/pob_details_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_list/pob_list_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/pob_persons/pob_persons_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/report/download_report_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/save_pob/save_pob_person_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/service_categories/service_categories_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/service_categories/service_categories_event.dart';
import 'package:gtm/pages/manage_trip/bloc/services/service_popup/save_service_popup_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/service_popup/service_popup_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/service_popup/service_popup_event.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/airport_requirement_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/flight_requirement_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/save_service_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/aircraft/customer_aircraft_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/aircraft/customer_sub_aircraft_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/look_up_list/lookup_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/look_up_list/save_lookup_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/save_trip_details_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/trip_details_bloc.dart';
import 'package:gtm/pages/manage_trip/manage_trip.dart';
import 'package:gtm/pages/operators/bloc/operator_bloc.dart';
import 'package:gtm/pages/people/bloc/cubit/companies_cubit.dart';
import 'package:gtm/pages/people/bloc/person_bloc.dart';
import 'package:gtm/pages/people/cubit/people_cubit.dart';
import 'package:gtm/pages/register/bloc/m_register_cubit.dart';
import 'package:gtm/pages/reset_password/bloc/m_forgot_password_cubit.dart';
import 'package:gtm/pages/reset_password/bloc/m_forgot_password_otp_cubit.dart';
import 'package:gtm/pages/reset_password/bloc/m_reset_password_cubit.dart';
import 'package:gtm/theme/app_theme.dart';
import 'package:gtm/utils/scroll_behaviour.dart';
import 'package:operator_repository/operator_repository.dart';
import 'package:people_repository/people_repository.dart';
import 'package:provider/provider.dart';
import 'package:service_category_repository/service_category_repository.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class App extends StatelessWidget {
  // App Members
  final String accessToken;
  final AuthInfo authInfo = AuthInfo();

  // Declare repositories here
  final AuthenticationRepository authenticationRepository;
  final TripManagerRepository tripManagerRepository;
  final AircraftRepository aircraftRepository;
  final CountryRepository countryRepository;
  final AirportRepository airportRepository;
  final PaginatedAirportRepository paginatedAirportRepository;
  final FlightCategoryRepository flightCategoryRepository;
  final OperatorRepository operatorRepository;
  final UserRepository userRepository;
  final FlightPurposeRepository flightPurposeRepository;
  final TabRepository tabRepository;
  final TripManagerDocumentsRepository tripManagerDocumentRepository;
  final TripManagerPOBRepository tripManagerPOBRepository;
  final TripManagerScheduleRepository tripManagerScheduleRepository;
  final TripManagerServiceRepository tripManagerServiceRepository;
  final CompanyProfileRepository companyProfileRepository;
  final PeopleRepository peopleRepository;
  final ServiceCategoryRepository serviceCategoriesRepository;

  App({
    Key? key,
    required this.accessToken,
    required this.authenticationRepository,
    required this.tripManagerRepository,
    required this.aircraftRepository,
    required this.countryRepository,
    required this.airportRepository,
    required this.flightCategoryRepository,
    required this.operatorRepository,
    required this.userRepository,
    required this.flightPurposeRepository,
    required this.paginatedAirportRepository,
    required this.tabRepository,
    required this.tripManagerDocumentRepository,
    required this.tripManagerPOBRepository,
    required this.tripManagerScheduleRepository,
    required this.tripManagerServiceRepository,
    required this.companyProfileRepository,
    required this.peopleRepository,
    required this.serviceCategoriesRepository,
  }) : super(key: key);

  /// auth repo
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthInfo>.value(
      value: authInfo,
      child: RepositoryProvider<AuthenticationRepository>.value(
        value: authenticationRepository,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AppBloc>(
              create: (BuildContext context) => AppBloc(
                authenticationRepository: authenticationRepository,
                userRepository: userRepository,
              ),
            ),
            BlocProvider<LoginCubit>(
              create: (BuildContext context) => LoginCubit(
                authenticationRepository,
              ),
            ),
            BlocProvider<MRegisterCubit>(
              create: (BuildContext context) => MRegisterCubit(
                authenticationRepository,
              ),
            ),
            BlocProvider<MForgotPasswordCubit>(
              create: (BuildContext context) => MForgotPasswordCubit(
                authenticationRepository,
              ),
            ),
            BlocProvider<MForgotPasswordOtpCubit>(
              create: (BuildContext context) => MForgotPasswordOtpCubit(
                authenticationRepository,
              ),
            ),
            BlocProvider<MResetPasswordCubit>(
              create: (BuildContext context) => MResetPasswordCubit(
                authenticationRepository,
              ),
            ),
            BlocProvider<AdvanceFilterCubit>(
              create: (BuildContext context) =>
                  AdvanceFilterCubit(tripManagerRepository, []),
            ),
            BlocProvider<TripOverviewDetailsCubit>(
              create: (BuildContext context) => TripOverviewDetailsCubit(
                tripManagerRepository,
              ),
            ),
            BlocProvider<HomeBloc>(
              create: (BuildContext context) => HomeBloc(
                tripManagerRepository: tripManagerRepository,
                userRepository: userRepository,
                aircraftRepository: aircraftRepository,
                flightCategoryRepository: flightCategoryRepository,
                operatorRepository: operatorRepository,
              ),
              // ..add(const InitiateTripDraftEvent())
              // ..add(FetchTripData()),
            ),
            BlocProvider<AircraftBloc>(
              create: (BuildContext context) => AircraftBloc(
                aircraftRepository: aircraftRepository,
              ),
            ),
            BlocProvider<CountryBloc>(
              create: (BuildContext context) => CountryBloc(
                countryRepository: countryRepository,
              ),
            ),
            BlocProvider<CountryAlertsBLoc>(
              create: (BuildContext context) => CountryAlertsBLoc(
                countryRepository: countryRepository,
              ),
            ),
            BlocProvider<CountryFlightRequirementsBloc>(
              create: (BuildContext context) => CountryFlightRequirementsBloc(
                countryRepository: countryRepository,
              ),
            ),
            BlocProvider<CountryGeneralInfoBloc>(
              create: (BuildContext context) => CountryGeneralInfoBloc(
                countryRepository: countryRepository,
              ),
            ),
            BlocProvider<CountryHealthCubit>(
              create: (BuildContext context) => CountryHealthCubit(
                countryRepository: countryRepository,
              ),
            ),
            BlocProvider<CountryPassportVisaCubit>(
              create: (BuildContext context) => CountryPassportVisaCubit(
                countryRepository: countryRepository,
              ),
            ),
            BlocProvider<CountrySanctionBloc>(
              create: (BuildContext context) => CountrySanctionBloc(
                countryRepository: countryRepository,
              ),
            ),
            BlocProvider<AirportBloc>(
              create: (BuildContext context) => AirportBloc(
                airportRepository: airportRepository,
              ),
            ),
            BlocProvider<PaginatedAirportBloc>(
              create: (BuildContext context) => PaginatedAirportBloc(
                paginatedAirportRepository: paginatedAirportRepository,
              ),
            ),
            BlocProvider<FlightCategoryBloc>(
              create: (BuildContext context) => FlightCategoryBloc(
                flightCategoryRepository: flightCategoryRepository,
              ),
            ),
            BlocProvider<OperatorBloc>(
              create: (BuildContext context) => OperatorBloc(
                operatorRepository: operatorRepository,
              ),
            ),
            BlocProvider<TabCubit>(
              create: (BuildContext context) => TabCubit(
                tabRepository: tabRepository,
              ),
            ),
            BlocProvider<DocumentFilterBloc>(
              create: (BuildContext context) => DocumentFilterBloc(
                tripManagerDocumentsRepository: tripManagerDocumentRepository,
              ),
            ),
            BlocProvider<DocumentsPDFBloc>(
              create: (BuildContext context) => DocumentsPDFBloc(
                tripManagerDocumentsRepository: tripManagerDocumentRepository,
              ),
            ),
            BlocProvider<POBListBloc>(
              create: (BuildContext context) => POBListBloc(
                tripManagerPOBRepository: tripManagerPOBRepository,
              ),
            ),
            BlocProvider<POBDetailBloc>(
              create: (BuildContext context) => POBDetailBloc(
                tripManagerPOBRepository: tripManagerPOBRepository,
              ),
            ),
            // BlocProvider<ScheduleCubit>(
            //   create: (BuildContext context) => ScheduleCubit(
            //     tripManagerScheduleRepository: tripManagerScheduleRepository,
            //   ),
            // ),
            BlocProvider<TripScheduleListBloc>(
              create: (BuildContext context) => TripScheduleListBloc(
                tripManagerScheduleRepository: tripManagerScheduleRepository,
                flightCategoryRepository: flightCategoryRepository,
              ),
            ),
            BlocProvider<POBPersonsBloc>(
              create: (BuildContext context) => POBPersonsBloc(
                tripManagerPOBRepository: tripManagerPOBRepository,
              ),
            ),
            BlocProvider<EditDeletePOBSequenceBloc>(
              create: (BuildContext context) => EditDeletePOBSequenceBloc(
                tripManagerPOBRepository: tripManagerPOBRepository,
              ),
            ),
            BlocProvider<SavePOBBloc>(
              create: (BuildContext context) => SavePOBBloc(
                tripManagerPOBRepository: tripManagerPOBRepository,
              ),
            ),
            BlocProvider<LookupBloc>(
              create: (BuildContext context) => LookupBloc(
                tripMangerRepository: tripManagerRepository,
              ),
            ),
            BlocProvider<SaveLookupBloc>(
              create: (BuildContext context) => SaveLookupBloc(
                tripMangerRepository: tripManagerRepository,
              ),
            ),
            BlocProvider<TripDetailsBloc>(
              create: (BuildContext context) => TripDetailsBloc(
                tripMangerRepository: tripManagerRepository,
              ),
            ),
            BlocProvider<SaveTripDetailsBloc>(
              create: (BuildContext context) => SaveTripDetailsBloc(
                tripMangerRepository: tripManagerRepository,
              ),
            ),
            BlocProvider<AirportCubit>(
              create: (BuildContext context) => AirportCubit(
                airportRepository: airportRepository,
              ),
            ),
            BlocProvider<CustomerAircraftBloc>(
              create: (context) {
                return CustomerAircraftBloc(
                  aircraftRepository: aircraftRepository,
                );
              },
            ),
            BlocProvider<CustomerSubAircraftBloc>(
              create: (context) {
                return CustomerSubAircraftBloc(
                  aircraftRepository: aircraftRepository,
                );
              },
            ),
            BlocProvider<CompanyProfileCubit>(
              create: (BuildContext context) => CompanyProfileCubit(
                companyProfileRepository: companyProfileRepository,
              ),
            ),
            BlocProvider<CustomerContactBloc>(
              create: (BuildContext context) => CustomerContactBloc(
                companyProfileRepository: companyProfileRepository,
              ),
            ),
            BlocProvider<CustomerNotesBloc>(
              create: (BuildContext context) => CustomerNotesBloc(
                companyProfileRepository: companyProfileRepository,
              ),
            ),
            BlocProvider<PrefrenceBloc>(
              create: (BuildContext context) => PrefrenceBloc(
                companyProfileRepository: companyProfileRepository,
              ),
            ),
            BlocProvider<CustomerDocumentBloc>(
              create: (BuildContext context) => CustomerDocumentBloc(
                companyProfileRepository: companyProfileRepository,
              ),
            ),
            BlocProvider<AircraftDocumentBloc>(
              create: (BuildContext context) => AircraftDocumentBloc(
                aircraftRepository: aircraftRepository,
              ),
            ),
            BlocProvider<ContactDetailsCubit>(
              create: (BuildContext context) => ContactDetailsCubit(
                companyProfileRepository: companyProfileRepository,
              ),
            ),
            BlocProvider<CompanyFlightCategoryCubit>(
              create: (BuildContext context) => CompanyFlightCategoryCubit(
                companyProfileRepository: companyProfileRepository,
              ),
            ),
            BlocProvider<CountryCubit>(
              create: (BuildContext context) => CountryCubit(
                countryRepository: countryRepository,
              ),
            ),
            BlocProvider<CountrySanctionsCubit>(
              create: (BuildContext context) => CountrySanctionsCubit(
                countryRepository: countryRepository,
              ),
            ),
            BlocProvider<PeopleCubit>(
              create: (BuildContext context) => PeopleCubit(
                peopleRepository: peopleRepository,
              ),
            ),
            BlocProvider<TripServiceBloc>(
              create: (context) => TripServiceBloc(
                  tripManagerServiceRepository: tripManagerServiceRepository),
            ),
            BlocProvider<FlightRequirementBloc>(
              create: (context) => FlightRequirementBloc(
                  tripManagerServiceRepository: tripManagerServiceRepository),
            ),
            BlocProvider<AirportRequirementBloc>(
              create: (context) => AirportRequirementBloc(
                  tripManagerServiceRepository: tripManagerServiceRepository),
            ),
            BlocProvider<ServiceCategoriesBloc>(
              create: (context) => ServiceCategoriesBloc(
                  tripMangerRepository: serviceCategoriesRepository)
                ..add(const FetchServiceCategories()),
            ),
            BlocProvider<ServicePopupBloc>(
              create: (context) => ServicePopupBloc(
                  tripManagerServiceRepository: tripManagerServiceRepository)
                ..add(const FetchTripPopup()),
            ),
            BlocProvider<TripBloc>(
              create: (context) =>
                  TripBloc(tripManagerRepository: tripManagerRepository)
                    ..add(const FetchTrips()),
            ),
            BlocProvider<TripStatisticBloc>(
              create: (context) => TripStatisticBloc(
                  tripManagerRepository: tripManagerRepository)
                ..add(const FetchTripStatistics()),
            ),
            BlocProvider<SaveServicePopupBloc>(
              create: (context) => SaveServicePopupBloc(
                  tripManagerServiceRepository: tripManagerServiceRepository),
            ),
            BlocProvider<SaveServiceBloc>(
              create: (context) => SaveServiceBloc(
                  tripManagerServiceRepository: tripManagerServiceRepository),
            ),
            BlocProvider<TripsBloc>(
                create: (context) =>
                    TripsBloc(aircraftRepository: aircraftRepository)),
            BlocProvider<PrefrenceBloc>(
              create: (context) => PrefrenceBloc(
                  companyProfileRepository: companyProfileRepository),
            ),
            BlocProvider<POBDownloadReportBloc>(
              create: (context) => POBDownloadReportBloc(
                  tripManagerPOBRepository: tripManagerPOBRepository),
            ),
            BlocProvider<PersonBloc>(
                create: (context) =>
                    PersonBloc(peopleRepository: peopleRepository)),
            BlocProvider<CompaniesCubit>(
                create: (context) =>
                    CompaniesCubit(peopleRepository: peopleRepository)),
            BlocProvider<AircraftDetailCubit>(
                create: (context) => AircraftDetailCubit(aircraftRepository))
          ],
          child: Builder(
            builder: (context) {
              if (accessToken.isNotEmpty) {
                context.read<AuthInfo>().login(accessToken);
              }
              GoRouter goRouter = initializeRouter(context);
              return MaterialApp.router(
                scrollBehavior: MyCustomScrollBehavior(),
                routeInformationParser: goRouter.routeInformationParser,
                routerDelegate: goRouter.routerDelegate,
                title: 'GTM | Global Trip Manager',
                debugShowCheckedModeBanner: false,
                theme: AppTheme().defaultTheme(),
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
              );
            },
          ),
        ),
      ),
    );
  }

  GoRouter initializeRouter(BuildContext context) {
    return GoRouter(
      routes: routes,
      initialLocation: Routes.welcome,
      redirect: (GoRouterState state) {
        bool isUserLoggedIn = context.read<AuthInfo>().loggedIn;
        final loggingIn = state.subloc == Routes.login;
        if (isUserLoggedIn) {
          if (state.subloc == Routes.welcome ||
              state.subloc == Routes.login ||
              state.subloc == Routes.forgotPassword ||
              state.subloc == Routes.otpVerify ||
              state.subloc == Routes.resetPassword) {
            return Routes.dashboard;
          }
          return null;
        } else if (state.subloc == Routes.welcome ||
            state.subloc == Routes.register ||
            state.subloc == Routes.forgotPassword ||
            state.subloc == Routes.otpVerify ||
            state.subloc == Routes.resetPassword) {
          return null;
        } else {
          return loggingIn ? null : Routes.welcome;
        }

        //return Routes.welcome;

        // final loggingIn = state.subloc == Routes.login;
        // LoginCubit appBloc = BlocProvider.of(context);
        // isUserLoggedIn = appBloc.state.status == FormzStatus.submissionSuccess;
        //
        // if (isUserLoggedIn) {
        //   return Routes.dashboard;
        // } else if (state.subloc == Routes.welcome ||
        //     state.subloc == Routes.register ||
        //     state.subloc == Routes.forgotPassword ||
        //     state.subloc == Routes.otpVerify ||
        //     state.subloc == Routes.resetPassword) {
        //   return null;
        // } else {
        //   return loggingIn ? null : Routes.login;
        // }
      },
      refreshListenable: GoRouterRefreshStream(
        context.read<AppBloc>().stream,
      ),
    );
  }
}
