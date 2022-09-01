import 'package:airport_repository/airport_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/airport/cubit/airport_cubit.dart';

class WAirportGeneralInfoPage extends StatefulWidget {
  final Airport airport;

  const WAirportGeneralInfoPage({required this.airport, Key? key})
      : super(key: key);

  @override
  State<WAirportGeneralInfoPage> createState() =>
      _WAirportGeneralInfoPageState();
}

class _WAirportGeneralInfoPageState extends State<WAirportGeneralInfoPage> {
  AirportGeneralInfo? _airportGeneralInfo;
  ScrollController mainScrollController = ScrollController();

  @override
  void didChangeDependencies() {
    fetchAircraftGeneralInfo();
    super.didChangeDependencies();
  }

  fetchAircraftGeneralInfo() {
    context
        .read<AirportCubit>()
        .getAirportGeneralInfo(widget.airport.airportId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AirportCubit, AirportState>(
        listener: (context, state) {},
        child: BlocBuilder<AirportCubit, AirportState>(
          buildWhen: (previous, current) {
            return previous.status != current.status;
          },
          builder: (context, state) {
            if (state.status == FetchAirportStatus.loading) {
              return loadingWidget();
            }
            if (state.status == FetchAirportStatus.initial) {}
            if (state.status == FetchAirportStatus.success) {
              if (state.airportGeneralInfo != null) {
                _airportGeneralInfo = state.airportGeneralInfo;
                log(_airportGeneralInfo!.toJson().toString());
              }
            }
            // _airportGeneralInfo = const AirportGeneralInfo(
            //   airportId: 10,
            //   name: "Mock Airport",
            //   countryId: 20,
            //   iata: "iata",
            //   icao: "icao",
            //   elevation: 500,
            //   longitude: "longitude",
            //   latitude: "latitude",
            //   civil: true,
            //   military: false,
            //   aoe: true,
            //   UASSupervisorySvc: false,
            //   slots: true,
            //   H24: false,
            //   USSouthernAOE: true,
            //   USLngdRights: false,
            //   USPreClear: true,
            //   ppr: false,
            //   customs: true,
            //   timezone: "timezone",
            //   DSTOffset: "DSTOffset",
            //   isDST: true,
            //   timezoneNote: "timezoneNote",
            //   Tower: "Tower",
            //   gmt: "gmt",
            //   Tower1: "Tower1",
            //   Ground: "Ground",
            //   Ground1: "Ground1",
            //   Clearance: "Clearance",
            //   ATIS: "ATIS",
            //   atcNote: "atcNote",
            //   operatingHoursNote: "operatingHoursNote",
            //   fireCategory: 3,
            //   fireCategoryNote: "fireCategoryNote",
            //   isFireCategoryUpgrade: true,
            //   JetA1: true,
            //   JetA: true,
            //   JetB: true,
            //   AVGas: true,
            //   TS1: true,
            //   fuelRestrictions: "fuelRestrictions",
            //   generalRemarks: "generalRemarks",
            //   cargoRestrictions: "cargoRestrictions",
            //   generalRemarksCargo: "generalRemarksCargo",
            //   runwayFacilitiesNote: "runwayFacilitiesNote",
            //   Commercial: true,
            //   CommercialParkingRestrictions: true,
            //   CommercialNotes: "CommercialNotes",
            //   GeneralAviation: true,
            //   GeneralAviationParkingRestrictions: true,
            //   GeneralAviationNotes: "GeneralAviationNotes",
            //   CustomsFromHours: "CustomsFromHours",
            //   CustomsToHours: "CustomsToHours",
            //   CustomsHoursUTC: true,
            //   operationalHours: "operationalHours",
            //   archived: true,
            //   uASPartnerAgent: "uASPartnerAgent",
            //   country: AirportCountry(),
            //   airportAttachmentsList: [],
            // );
            return Padding(
              padding: const EdgeInsets.all(spacing8),
              child: SingleChildScrollView(
                controller: mainScrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleWidget(airportName, widget.airport.name),
                    _buildTypeRestrictionsWidget(
                      civilBool: _airportGeneralInfo!.civil,
                      aoeintlBool: _airportGeneralInfo!.aoe,
                      customsBool: _airportGeneralInfo!.customs,
                      h24Bool: _airportGeneralInfo!.H24,
                      militaryBool: _airportGeneralInfo!.military,
                      pprBool: _airportGeneralInfo!.ppr,
                      slotsBool: _airportGeneralInfo!.slots,
                      uasSupervisorySvcBool:
                          _airportGeneralInfo!.UASSupervisorySvc,
                      usLandRightsBool: _airportGeneralInfo!.USLngdRights,
                      usSouthernAoeBool: _airportGeneralInfo!.USSouthernAOE,
                      uspreClearBool: _airportGeneralInfo!.USPreClear,
                    ),
                    _buildDetailsWidget(),
                    ListView(
                      shrinkWrap: true,
                      children: [
                        _buildInfoWidget(
                            expand: true, section: "runway_information"),
                        _buildInfoWidget(expand: true, section: "timezone"),
                        _buildInfoWidget(
                            expand: true, section: "atc_frequencies"),
                        _buildInfoWidget(
                            expand: true, section: "operating_hours"),
                        _buildInfoWidget(expand: true, section: "categories"),
                        _buildInfoWidget(
                            expand: true, section: "airport_facilities"),
                        _buildInfoWidget(expand: true, section: "fuel_details"),
                        _buildInfoWidget(
                            expand: true, section: "general_remarks"),
                        _buildInfoWidget(
                            expand: true, section: "departure_procedure"),
                        _buildInfoWidget(
                            expand: true, section: "arrival_procedure"),
                        _buildInfoWidget(expand: true, section: "cargo_flight"),
                        _buildInfoWidget(
                            expand: true, section: "operational_notes"),
                        _buildInfoWidget(expand: true, section: "attachments"),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTitleWidget(String key, String? value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(spacing8),
              child: appText(
                key + ':',
                color: AppColors.charcoalGrey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(spacing8),
              child: appText(
                value ?? '',
                color: AppColors.charcoalGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildTypeRestrictionsWidget({
    bool? civilBool = false,
    bool? militaryBool = false,
    bool? aoeintlBool = false,
    bool? slotsBool = false,
    bool? h24Bool = false,
    bool? uspreClearBool = false,
    bool? usSouthernAoeBool = false,
    bool? usLandRightsBool = false,
    bool? uasSupervisorySvcBool = false,
    bool? pprBool = false,
    bool? customsBool = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: spacing20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appText("Type/Restrictions: ",
              color: AppColors.charcoalGrey, fontWeight: FontWeight.bold),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(spacing16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        civilBool!
                            ? SvgPicture.asset(AppImages.onlineAvailabeAsset)
                            : SvgPicture.asset(AppImages.minusIcon),
                        const Padding(
                          padding: EdgeInsets.all(spacing10),
                          child: Text(civil),
                        ),
                      ],
                    ),
                    Row(children: [
                      militaryBool!
                          ? SvgPicture.asset(AppImages.onlineAvailabeAsset)
                          : SvgPicture.asset(AppImages.minusIcon),
                      const Padding(
                        padding: EdgeInsets.all(spacing10),
                        child: Text(military),
                      ),
                    ]),
                    Row(children: [
                      aoeintlBool!
                          ? SvgPicture.asset(AppImages.onlineAvailabeAsset)
                          : SvgPicture.asset(AppImages.minusIcon),
                      const Padding(
                        padding: EdgeInsets.all(spacing10),
                        child: Text(aoeIntl),
                      ),
                    ]),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(spacing16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        slotsBool!
                            ? SvgPicture.asset(AppImages.onlineAvailabeAsset)
                            : SvgPicture.asset(AppImages.minusIcon),
                        const Padding(
                          padding: EdgeInsets.all(spacing10),
                          child: Text(slots),
                        ),
                      ],
                    ),
                    Row(children: [
                      h24Bool!
                          ? SvgPicture.asset(AppImages.onlineAvailabeAsset)
                          : SvgPicture.asset(AppImages.minusIcon),
                      const Padding(
                        padding: EdgeInsets.all(spacing10),
                        child: Text(h24),
                      ),
                    ]),
                    Row(children: [
                      uspreClearBool!
                          ? SvgPicture.asset(AppImages.onlineAvailabeAsset)
                          : SvgPicture.asset(AppImages.minusIcon),
                      const Padding(
                        padding: EdgeInsets.all(spacing10),
                        child: Text(uspreClear),
                      ),
                    ]),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(spacing16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        usSouthernAoeBool!
                            ? SvgPicture.asset(AppImages.onlineAvailabeAsset)
                            : SvgPicture.asset(AppImages.minusIcon),
                        const Padding(
                          padding: EdgeInsets.all(spacing10),
                          child: Text(usSouthernAoe),
                        ),
                      ],
                    ),
                    Row(children: [
                      usLandRightsBool!
                          ? SvgPicture.asset(AppImages.onlineAvailabeAsset)
                          : SvgPicture.asset(AppImages.minusIcon),
                      const Padding(
                        padding: EdgeInsets.all(spacing10),
                        child: Text(usLandRights),
                      ),
                    ]),
                    Row(children: [
                      uasSupervisorySvcBool!
                          ? SvgPicture.asset(AppImages.onlineAvailabeAsset)
                          : SvgPicture.asset(AppImages.minusIcon),
                      const Padding(
                        padding: EdgeInsets.all(spacing10),
                        child: Text(uasSupervisorySvc),
                      ),
                    ]),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(spacing16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        pprBool!
                            ? SvgPicture.asset(AppImages.onlineAvailabeAsset)
                            : SvgPicture.asset(AppImages.minusIcon),
                        const Padding(
                          padding: EdgeInsets.all(spacing10),
                          child: Text(ppr),
                        ),
                      ],
                    ),
                    Row(children: [
                      customsBool!
                          ? SvgPicture.asset(AppImages.onlineAvailabeAsset)
                          : SvgPicture.asset(AppImages.minusIcon),
                      const Padding(
                        padding: EdgeInsets.all(spacing10),
                        child: Text(customs),
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appText("ICAO Code:",
                    color: AppColors.charcoalGrey, fontWeight: FontWeight.bold),
                appText("Alternative Airport:",
                    color: AppColors.charcoalGrey, fontWeight: FontWeight.bold),
                appText("Bearing to City Center:",
                    color: AppColors.charcoalGrey, fontWeight: FontWeight.bold),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appText(_airportGeneralInfo?.icao ?? "",
                    color: AppColors.charcoalGrey),
                appText(_airportGeneralInfo?.Alternatives.toString() ?? "",
                    color: AppColors.charcoalGrey),
                appText(_airportGeneralInfo?.bearingToCityCenter ?? "",
                    color: AppColors.charcoalGrey),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appText("IATA Code:",
                    color: AppColors.charcoalGrey, fontWeight: FontWeight.bold),
                appText("Elevation(ft):",
                    color: AppColors.charcoalGrey, fontWeight: FontWeight.bold),
                appText("Driving time:",
                    color: AppColors.charcoalGrey, fontWeight: FontWeight.bold),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appText(_airportGeneralInfo?.iata ?? "",
                    color: AppColors.charcoalGrey),
                appText(_airportGeneralInfo?.elevation.toString() ?? "",
                    color: AppColors.charcoalGrey),
                appText(_airportGeneralInfo?.drivingTime ?? "",
                    color: AppColors.charcoalGrey),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appText("Country:",
                    color: AppColors.charcoalGrey, fontWeight: FontWeight.bold),
                appText("Latitude:",
                    color: AppColors.charcoalGrey, fontWeight: FontWeight.bold),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appText(_airportGeneralInfo?.country.name ?? "",
                    color: AppColors.charcoalGrey),
                appText(_airportGeneralInfo?.latitude ?? "",
                    color: AppColors.charcoalGrey),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appText("City:",
                    color: AppColors.charcoalGrey, fontWeight: FontWeight.bold),
                appText("Longitude:",
                    color: AppColors.charcoalGrey, fontWeight: FontWeight.bold),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appText(_airportGeneralInfo?.airportCity?.city ?? "",
                    color: AppColors.charcoalGrey),
                appText(_airportGeneralInfo?.longitude ?? "",
                    color: AppColors.charcoalGrey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoWidget({required bool expand, required String section}) {
    Widget childContainer = Container();
    switch (section) {
      case "runway_information":
        {
          // String? RunwayLights;
          // String runwayFacilitiesNote;
          // final List<String>? RunwayApproaches;
          // final List<String>? RunwayInformation;
          childContainer = Container();
          break;
        }
      case "timezone":
        {
          childContainer = Container();
          break;
        }
      case "atc_frequencies":
        {
          childContainer = Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appText("Tower: ", color: AppColors.charcoalGrey),
                  Expanded(
                    child: appText(_airportGeneralInfo!.Tower,
                        color: AppColors.charcoalGrey),
                  ),
                  appText("Ground: ", color: AppColors.charcoalGrey),
                  Expanded(
                    child: appText(_airportGeneralInfo!.Ground,
                        color: AppColors.charcoalGrey),
                  ),
                  appText("ATIS: ", color: AppColors.charcoalGrey),
                  Expanded(
                    child: appText(_airportGeneralInfo!.ATIS,
                        color: AppColors.charcoalGrey),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appText("Tower1: ", color: AppColors.charcoalGrey),
                  Expanded(
                    child: appText(_airportGeneralInfo!.Tower1,
                        color: AppColors.charcoalGrey),
                  ),
                  appText("Ground1: ", color: AppColors.charcoalGrey),
                  Expanded(
                    child: appText(_airportGeneralInfo!.Ground1,
                        color: AppColors.charcoalGrey),
                  ),
                  appText("Clearance: ", color: AppColors.charcoalGrey),
                  Expanded(
                    child: appText(_airportGeneralInfo!.Clearance,
                        color: AppColors.charcoalGrey),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appText("Notes: ", color: AppColors.charcoalGrey),
                  Expanded(
                    child: appText(_airportGeneralInfo!.atcNote,
                        color: AppColors.charcoalGrey),
                  ),
                ],
              ),
            ],
          );
          break;
        }
      case "operating_hours":
        {
          childContainer = Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appText("Airport Hours: ", color: AppColors.charcoalGrey),
                  Expanded(
                    child: appText(
                        ((_airportGeneralInfo!.AirportFromHours ?? "") +
                            " " +
                            (_airportGeneralInfo!.AirportToHours ?? "")),
                        color: AppColors.charcoalGrey),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        appText("LCL"),
                        Switch(
                          value: _airportGeneralInfo!.AirportHoursUTC ?? true,
                          onChanged: (value) {},
                          activeTrackColor: AppColors.greyColor,
                          activeColor: AppColors.deepLilac,
                          inactiveTrackColor: AppColors.greyColor,
                          inactiveThumbColor: AppColors.deepLilac,
                        ),
                        appText("UTC"),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appText("Tower Hours: ", color: AppColors.charcoalGrey),
                  Expanded(
                    child: appText(
                        ((_airportGeneralInfo!.TowerFromHours ?? "") +
                            " " +
                            (_airportGeneralInfo!.TowerToHours ?? "")),
                        color: AppColors.charcoalGrey),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        appText("LCL"),
                        Switch(
                          value: _airportGeneralInfo!.TowerHoursUTC ?? true,
                          onChanged: (value) {},
                          activeTrackColor: AppColors.greyColor,
                          activeColor: AppColors.deepLilac,
                          inactiveTrackColor: AppColors.greyColor,
                          inactiveThumbColor: AppColors.deepLilac,
                        ),
                        appText("UTC"),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appText("Notes: ", color: AppColors.charcoalGrey),
                  Expanded(
                    child: appText((_airportGeneralInfo!.operatingHoursNote),
                        color: AppColors.charcoalGrey),
                  ),
                ],
              ),
            ],
          );
          break;
        }
      case "airport_facilities":
        {
          childContainer = Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appText("Noise Category: ", color: AppColors.charcoalGrey),
                  Expanded(
                    child: appText(_airportGeneralInfo!.noiseCategory ?? '',
                        color: AppColors.charcoalGrey),
                  ),
                  appText("Airport Reference Code: ",
                      color: AppColors.charcoalGrey),
                  Expanded(
                    child: appText(_airportGeneralInfo!.referenceCode ?? '',
                        color: AppColors.charcoalGrey),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appText("Fire Category: ", color: AppColors.charcoalGrey),
                  Expanded(
                    child: appText(
                        _airportGeneralInfo!.fireCategory != null
                            ? _airportGeneralInfo!.fireCategory.toString()
                            : '',
                        color: AppColors.charcoalGrey),
                  ),
                  Row(children: [
                    _airportGeneralInfo!.isFireCategoryUpgrade
                        ? SvgPicture.asset(AppImages.onlineAvailabeAsset)
                        : SvgPicture.asset(AppImages.minusIcon),
                    Padding(
                      padding: const EdgeInsets.all(spacing10),
                      child: appText("Fire Category Upgrade",
                          color: AppColors.charcoalGrey),
                    ),
                  ]),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appText("Notes: ", color: AppColors.charcoalGrey),
                  Expanded(
                    child: appText(_airportGeneralInfo!.fireCategoryNote,
                        color: AppColors.charcoalGrey),
                  ),
                ],
              ),
            ],
          );
          break;
        }
      case "fuel_details":
        {
          childContainer = Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      _airportGeneralInfo!.JetA1
                          ? SvgPicture.asset(AppImages.onlineAvailabeAsset)
                          : SvgPicture.asset(AppImages.minusIcon),
                      Padding(
                        padding: const EdgeInsets.all(spacing10),
                        child: appText("JetA1", color: AppColors.charcoalGrey),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      _airportGeneralInfo!.JetA
                          ? SvgPicture.asset(AppImages.onlineAvailabeAsset)
                          : SvgPicture.asset(AppImages.minusIcon),
                      Padding(
                        padding: const EdgeInsets.all(spacing10),
                        child: appText("JetA", color: AppColors.charcoalGrey),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      _airportGeneralInfo!.JetB
                          ? SvgPicture.asset(AppImages.onlineAvailabeAsset)
                          : SvgPicture.asset(AppImages.minusIcon),
                      Padding(
                        padding: const EdgeInsets.all(spacing10),
                        child: appText("JetB", color: AppColors.charcoalGrey),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      _airportGeneralInfo!.AVGas
                          ? SvgPicture.asset(AppImages.onlineAvailabeAsset)
                          : SvgPicture.asset(AppImages.minusIcon),
                      Padding(
                        padding: const EdgeInsets.all(spacing10),
                        child: appText("AVGas", color: AppColors.charcoalGrey),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      _airportGeneralInfo!.TS1
                          ? SvgPicture.asset(AppImages.onlineAvailabeAsset)
                          : SvgPicture.asset(AppImages.minusIcon),
                      Padding(
                        padding: const EdgeInsets.all(spacing10),
                        child: appText("TS1", color: AppColors.charcoalGrey),
                      ),
                    ]),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appText("Restrictions: ", color: AppColors.charcoalGrey),
                  Expanded(
                    child: appText(_airportGeneralInfo!.fuelRestrictions),
                  ),
                ],
              )
            ],
          );
          break;
        }
      case "general_remarks":
        {
          childContainer = appText(
            "Notes" + (_airportGeneralInfo?.generalRemarks ?? ""),
            color: AppColors.charcoalGrey,
          );
          break;
        }
      case "departure_procedure":
        {
          childContainer = Container();
          break;
        }
      case "arrival_procedure":
        {
          childContainer = Container();
          break;
        }
      case "cargo_flight":
        {
          childContainer = Container();
          break;
        }
      case "operational_notes":
        {
          childContainer = Container();
          break;
        }
      case "attachments":
        {
          childContainer = Container();
          break;
        }
      default:
        {
          childContainer = Container();
          break;
        }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.paleGrey,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: appText(
                      section.replaceAll(RegExp('_'), ' ').toUpperCase(),
                      color: AppColors.charcoalGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(Icons.expand_more),
                ],
              ),
              Container(
                color: AppColors.whiteColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(child: childContainer),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
