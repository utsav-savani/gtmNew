import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/countries/views/mobile/m_countries_list_page.dart';
import 'package:gtm/pages/home/view/web/components/menu_item.dart';
import 'package:gtm/pages/operators/views/mobile/m_aircraft.dart';
import 'package:gtm/pages/operators/views/mobile/m_airports.dart';
import 'package:gtm/pages/operators/views/mobile/m_apis_submission.dart';
import 'package:gtm/pages/operators/views/mobile/m_checklist.dart';
import 'package:gtm/pages/operators/views/mobile/m_company_profile.dart';
import 'package:gtm/pages/operators/views/mobile/m_executive_travel.dart';
import 'package:gtm/pages/operators/views/mobile/m_logs.dart';
import 'package:gtm/pages/operators/views/mobile/m_people.dart';
import 'package:gtm/pages/operators/views/mobile/m_user_management.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';
import 'package:gtm/pages/home/view/web/_common/launch_url.dart';

class AppDrawerMobile extends StatefulWidget {
  const AppDrawerMobile({Key? key}) : super(key: key);

  @override
  State<AppDrawerMobile> createState() => _AppDrawerMobileState();
}

class _AppDrawerMobileState extends State<AppDrawerMobile> {
  int _selectedDestination = 0;
  final TripManagerScheduleRepository _tripManagerScheduleRepository =
      TripManagerScheduleRepository();
  @override
  Widget build(BuildContext context) {
    return MobileDrawer(
      selectedDestination: _selectedDestination,
      tripManagerScheduleRepository: _tripManagerScheduleRepository,
    );
  }

  void selectDestination(int index) {
    _selectedDestination = index;
    setState(() {});
  }
}

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({
    Key? key,
    required int selectedDestination,
    required TripManagerScheduleRepository tripManagerScheduleRepository,
  })  : _selectedDestination = selectedDestination,
        _tripManagerScheduleRepository = tripManagerScheduleRepository,
        super(key: key);

  final int _selectedDestination;
  final TripManagerScheduleRepository _tripManagerScheduleRepository;

  @override
  Widget build(BuildContext context) {
    // main Items List
    List<SideMenuItem> _mainMenuItems = [
      SideMenuItem(
        icon: AppImages.tripManagerIcon,
        title: tripManagerTitle,
        label: '',
        type: 'menu',
        shortname: 'tripmanager',
        page: Container(),
      ),
      SideMenuItem(
        icon: AppImages.apisSubmissionIcon,
        title: apisSubmissionTitle,
        label: 'soon',
        type: 'menu',
        page: const MApisSubmissionPage(),
      ),
      SideMenuItem(
        icon: AppImages.executiveTravelDeskIcon,
        title: executiveTravelDeskTitle,
        label: 'soon',
        type: 'menu',
        page: const MExecutiveTravelPage(),
      ),
      SideMenuItem(
        icon: AppImages.passportSvg,
        title: passportTitle,
        label: '',
        type: 'menu',
        shortname: TIMATIC,
        page: Container(),
      ),
      SideMenuItem(
        icon: AppImages.contentManagementIcon,
        title: contentManagementTitle,
        label: '',
        type: 'group',
        page: Container(),
      ),
      SideMenuItem(
        icon: AppImages.companyProfileIcon,
        title: companyProfileTitle,
        label: '',
        type: 'menu',
        page: const MCompanyProfilePage(),
      ),
      SideMenuItem(
        icon: AppImages.peopleIcon,
        title: peopleTitle,
        label: '',
        type: 'menu',
        page: const MPeoplePage(),
      ),
      SideMenuItem(
        icon: AppImages.aircraftIcon,
        title: aircraftTitle,
        label: '',
        type: 'menu',
        page: const MAircraftsPage(),
      ),
      SideMenuItem(
        icon: AppImages.airportsIcon,
        title: airportsTitle,
        label: '',
        type: 'menu',
        page: const MAirportsPage(),
      ),
      SideMenuItem(
        icon: AppImages.countriesIcon,
        title: countriesTitle,
        label: '',
        type: 'menu',
        page: const MCountriesListPage(),
      ),
      SideMenuItem(
        icon: AppImages.checklistIcon,
        title: checklistTitle,
        label: 'soon',
        type: 'menu',
        page: const MChecklistPage(),
      ),
      SideMenuItem(
        icon: AppImages.settingsIcon,
        title: settingsTitle,
        label: '',
        type: 'group',
        page: Container(),
      ),
      SideMenuItem(
        icon: AppImages.userManagementIcon,
        title: userManagementTitle,
        label: '',
        type: 'menu',
        page: const MUserManagement(),
      ),
      SideMenuItem(
        icon: AppImages.logsIcon,
        title: logsTitle,
        label: '',
        type: 'menu',
        page: const MLogsPage(),
      ),
    ];

    double radius = 50;
    return ClipRRect(
      borderRadius: BorderRadius.only(topRight: Radius.circular(radius)),
      child: Drawer(
        child: Column(
          children: [
            height(50),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: AppColors.lightPink,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(radius),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Image.asset(
                      AppImages.gtmLogo,
                      width: 212,
                    ),
                  ),
                  Container(
                    height: 54,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(30, 0, 20, 0),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Padding(
                            padding: paddingMedium,
                            child: InkWell(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    width: spacing32,
                                    height: spacing32,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(userAsset),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          FutureBuilder(
                              future: getUserData(),
                              builder: (context, builder) {
                                final userName = builder.data.toString();
                                return Text(
                                  userName,
                                  style: const TextStyle(
                                    color: AppColors.blackColor,
                                  ),
                                );
                              }),
                          const Icon(
                            Icons.expand_more_rounded,
                            color: AppColors.blackColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _mainMenuItems.length,
                itemBuilder: (context, index) {
                  final item = _mainMenuItems[index];
                  return _buildMenuItem(context, item, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(context, SideMenuItem menuItemParam, index) {
    Color menuLineColor = menuItemParam.type == 'group'
        ? AppColors.brightPink
        : AppColors.whiteColor;
    Color menuBarLineColor = menuItemParam.type == 'group'
        ? AppColors.brightPink
        : AppColors.lightBlueGrey;
    Color menuTextColor = AppColors.sidePanelColor;
    double menuItemHeight = 44;
    return GestureDetector(
      onTap: () async {
        if (menuItemParam.type == 'menu') {
          if (menuItemParam.shortname == TIMATIC) {
            timaticLaunchUrl();
          } else if (menuItemParam.shortname == 'tripmanager') {
            Navigator.of(context).pop();
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => menuItemParam.page,
              ),
            );
          }
        }
      },
      child: Container(
        color: menuLineColor,
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: <Widget>[
            _buildMenuItemSec(
              menuBarLineColor: menuBarLineColor,
              menuItemHeight: menuItemHeight,
              menuItemParam: menuItemParam,
              menuTextColor: menuTextColor,
            ),
            if (menuItemParam.label == 'soon')
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  AppImages.comingSoonImage,
                  height: menuItemHeight,
                  width: menuItemHeight,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItemSec({
    menuBarLineColor,
    menuItemHeight,
    menuItemParam,
    menuTextColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: menuBarLineColor,
          ),
        ),
      ),
      height: menuItemHeight,
      padding: menuItemParam.type == 'menu'
          ? const EdgeInsets.fromLTRB(16, 0, 8, 8)
          : const EdgeInsets.fromLTRB(4, 8, 8, 8),
      child: Row(
        children: [
          SizedBox(
            width: menuItemHeight,
            child: SvgPicture.asset(
              menuItemParam.icon,
              color: menuTextColor,
              semanticsLabel: menuItemParam.title,
            ),
          ),
          Text(
            menuItemParam.title,
            style: TextStyle(
              color: menuTextColor,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
