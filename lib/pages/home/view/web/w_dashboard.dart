import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/aircraft/views/web/w_aircraft_list_page.dart';
import 'package:gtm/pages/airport/views/web/w_airport_list_screen.dart';
import 'package:gtm/pages/countries/views/web/w_countries_list_page.dart';
import 'package:gtm/pages/home/dashboard/trip_dashboard.dart';
import 'package:gtm/pages/home/dashboard/trip_dashboard_v2.dart';
import 'package:gtm/pages/home/home.dart';
import 'package:gtm/pages/home/view/web/_common/launch_url.dart';
import 'package:gtm/pages/home/view/web/_common/on_hover_button.dart';
import 'package:gtm/pages/home/view/web/components/menu_item.dart';
import 'package:gtm/pages/home/view/web/components/tab_functions.dart';
import 'package:gtm/pages/home/view/web/components/tab_header.dart';
import 'package:gtm/pages/home/view/web/tab_pages/w_apis_submissions_page.dart';
import 'package:gtm/pages/home/view/web/tab_pages/w_checklist_page.dart';
import 'package:gtm/pages/home/view/web/tab_pages/w_company_profile_page.dart';
import 'package:gtm/pages/home/view/web/tab_pages/w_executive_traveldesk_page.dart';
import 'package:gtm/pages/home/view/web/tab_pages/w_logs_page.dart';
import 'package:gtm/pages/home/view/web/tab_pages/w_passport_visa_health_page.dart';
import 'package:gtm/pages/home/view/web/tab_pages/w_people_page.dart';
import 'package:gtm/pages/home/view/web/tab_pages/w_usermanagement_page.dart';
import 'package:gtm/pages/manage_trip/manage_trip.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

bool sidebarOpen = false;

class WebDashBoard extends StatefulWidget {
  const WebDashBoard({Key? key}) : super(key: key);

  @override
  State<WebDashBoard> createState() => _WebDashBoardState();
}

class _WebDashBoardState extends State<WebDashBoard>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  int selectedMenuItem = 0;
  GlobalKey stickyAnimatedContainerKey = GlobalKey();
  int currentIndexTab = 0;
  ScrollController listScrollController = ScrollController();

  //late TabHandler tabHandler;
  List<GtmTab> gtmTabLocalList = [];
  List<GtmTab> userSelectedTabList = [];
  late double mainWidgetHeight,
      mainWidgetWidth,
      menuItemHeight,
      menuItemWidth,
      sidePanelWidth;
  late Size windowSize;
  late int activeTabId = 0;

  TripDetail? tripDetail;

  void setSidebarState() {
    setState(() {});
  }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // add buildVersionNumber to the Version prefix from utilities.dart
    getVersionNumber().then((str) {
      versionNumber = versionNumberPrefix +
          (int.parse(str.split('-')[0]) / 1000).toString();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  void tabListener() {
    activeTabId = _tabController.index;
  }

  @override
  Widget build(BuildContext context) {
    // getting the size of the window
    windowSize = MediaQuery.of(context).size;
    menuItemHeight = sidebarOpen ? openPanelItemHeight : closedPanelItemHeight;
    menuItemWidth = sidebarOpen ? openPanelWidth : closedPanelWidth;
    sidePanelWidth = menuItemWidth;

    mainWidgetHeight = windowSize.height - appBarHeight;
    mainWidgetWidth = windowSize.width - sidePanelWidth;

    super.build(context);

    List<GtmTab> gtmTabLocalListAndViews = <GtmTab>[
      /// adding the GtmTab object with TripManagerPage default 0
      GtmTab(
        isActive: true,
        name: tripManager,
        tab: tabHeader(true, tripManagerTitle, context),
        page: Container(),
      ),
    ];

    return BlocBuilder<TabCubit, TabState>(
      builder: (context, state) {
        if (state is TabInitial) {
          context.read<TabCubit>().addTab(gtmTabLocalListAndViews.first);
        }
        if (state is TabSuccess) {
          gtmTabLocalList = state.gtmTabList;
          _tabController =
              TabController(length: gtmTabLocalList.length, vsync: this);
          // TODO: fix not updating activeTabId when clicking on tab header
          _tabController.addListener(() => tabListener);
          _tabController.index = activeTabId;

          // gtmTabLocalListAndViews[0].page = TripDashboardOld(
          //   tabController: _tabController,
          //   tabControllerIndex: _tripTabControllerIndexGet,
          // );
          gtmTabLocalListAndViews[0].page = TripDashboardV2(
            tabController: _tabController,
            tabControllerIndex: _tripTabControllerIndexGet,
          );
        } else if (state is TabFailure) {
          debugPrint('failed to load on the front end');
        }
        return BlocBuilder<TripOverviewDetailsCubit, TripOverviewDetailsState>(
            builder: (context, state) {
          return Material(
              child: Row(
            children: <Widget>[
              _buildSidePanel(),
              Flexible(
                child: Column(
                  children: [
                    webAppBar(context),
                    _buildTabs(),
                  ],
                ),
              )
              // selectedPage(selectedMenuItem)),
            ],
          ));
        });
      },
    );
  }

  Widget _buildSidePanel() {
    //variables for height of ListView
    int mainMenuItemCount = 4, cmsMenuItemCount = 7;
    sidebarOpen
        ? {mainMenuItemCount = 4, cmsMenuItemCount = 7}
        : {mainMenuItemCount = 4, cmsMenuItemCount = 6};

    // main Items List
    List<SideMenuItem> mainMenuItems = [
      SideMenuItem(
        icon: AppImages.tripManagerIcon,
        title: tripManagerTitle,
        label: '',
        type: 'menu',
        page: Container(),
      ),
      SideMenuItem(
        icon: AppImages.apisSubmissionIcon,
        title: apisSubmissionTitle,
        label: 'soon',
        type: 'menu',
        page: const WApisSubmissions(),
      ),
      SideMenuItem(
        icon: AppImages.executiveTravelDeskIcon,
        title: executiveTravelDeskTitle,
        label: 'soon',
        type: 'menu',
        page: const WExecutiveTravelDeskPage(),
      ),
      SideMenuItem(
        icon: AppImages.passportSvg,
        title: passportTitle,
        label: '',
        type: 'menu',
        shortname: TIMATIC,
        page: const PassportHealthVisaPage(),
      ),
    ];

    // cms Items List
    List<SideMenuItem> cmsMenuItems = [
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
        page: const WCompanyProfilePage(),
      ),
      SideMenuItem(
        icon: AppImages.peopleIcon,
        title: peopleTitle,
        label: '',
        type: 'menu',
        page: const WPeoplePage(),
      ),
      SideMenuItem(
        icon: AppImages.aircraftIcon,
        title: aircraftTitle,
        label: '',
        type: 'menu',
        page: const WAircraftListPage(),
      ),
      SideMenuItem(
        icon: AppImages.airportsIcon,
        title: airportsTitle,
        label: '',
        type: 'menu',
        page: const WAirportListPage(),
      ),
      SideMenuItem(
        icon: AppImages.countriesIcon,
        title: countriesTitle,
        label: '',
        type: 'menu',
        page: const WCountriesListPage(),
      ),
      SideMenuItem(
        icon: AppImages.checklistIcon,
        title: checklistTitle,
        label: 'soon',
        type: 'menu',
        page: const WChecklistPage(),
      ),
    ];

    // settings Items List
    List<SideMenuItem> settingsMenuItems = [
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
        page: const WUserManagementPage(),
      ),
      SideMenuItem(
        icon: AppImages.logsIcon,
        title: logsTitle,
        label: '',
        type: 'menu',
        page: const WLogsPage(),
      ),
    ];
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              // header
              Container(
                  width: sidePanelWidth,
                  height: sidePanelLogoBox,
                  color: AppColors.paleGrey1,
                  child: sidebarOpen
                      ? Row(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              width: 252,
                              child: Image.asset(
                                AppImages.gtmLogo,
                                width: 212,
                              ),
                            ),
                            Expanded(
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    /// open the panel
                                    sidebarOpen = !sidebarOpen;
                                    setSidebarState();
                                  },
                                  child: SizedBox(
                                    height: 32,
                                    width: 32,
                                    child: SvgPicture.asset(
                                      AppImages.collapseMenuIcon,
                                      color: AppColors.tableHeaderColor,
                                      semanticsLabel: 'close',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: Image.asset(
                                AppImages.gtmLogoIcon,
                              ),
                            ),
                            Expanded(
                              child: OnHoverButton(builder: (isHovered) {
                                return GestureDetector(
                                  onTap: () {
                                    /// open the panel
                                    sidebarOpen = !sidebarOpen;
                                    setSidebarState();
                                  },
                                  child: const Icon(
                                    Icons.menu,
                                    color: AppColors.sidePanelColor,
                                  ),
                                );
                              }),
                            ),
                          ],
                        )),
              Container(
                width: sidePanelWidth,
                color: AppColors.sidePanelColor,
                height: menuItemHeight,
              ),
              // menu items
              Expanded(
                child: Container(
                  width: sidePanelWidth,
                  color: AppColors.sidePanelColor,
                  child: CustomScrollView(slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: menuItemHeight * mainMenuItemCount,
                            child: ListView.builder(
                                itemCount: mainMenuItems.length,
                                itemBuilder: (context, index) {
                                  final item = mainMenuItems[index];
                                  return _buildMenuItem(item, index);
                                }),
                          ),
                          SizedBox(
                            height: menuItemHeight,
                          ),
                          SizedBox(
                            height: menuItemHeight * cmsMenuItemCount,
                            child: ListView.builder(
                                itemCount: cmsMenuItems.length,
                                itemBuilder: (context, index) {
                                  final item = cmsMenuItems[index];
                                  return _buildMenuItem(item, index);
                                }),
                          ),
                          SizedBox(
                            height: menuItemHeight,
                          ),
                          SizedBox(
                            height: menuItemHeight * mainMenuItemCount,
                            child: ListView.builder(
                                itemCount: settingsMenuItems.length,
                                itemBuilder: (context, index) {
                                  final item = settingsMenuItems[index];
                                  return _buildMenuItem(item, index);
                                }),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: appText(
            versionNumber,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(SideMenuItem menuItemParam, index) {
    double collapsedMenuIconSize = 24;
    GtmTab gtmTab = GtmTab(
      isActive: true,
      name: menuItemParam.title,
      tab: tabHeader(false, menuItemParam.title, context),
      page: menuItemParam.page,
      shortname: menuItemParam.shortname,
    );
    var colorToggle = index % 2 == 0;
    Color menuLineColor = menuItemParam.type == 'group'
        ? AppColors.palePurple
        : colorToggle
            ? AppColors.palePurple2
            : AppColors.sidePanelColor;
    return sidebarOpen
        ? OnHoverButton(builder: (isHovered) {
            isHovered = menuItemParam.type == 'group' ? false : isHovered;
            final buttonTextColor =
                isHovered ? AppColors.palePurple : Colors.white;
            return GestureDetector(
              onTap: () => _openTab(menuItemParam, gtmTab),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 44,
                    color: menuLineColor,
                    padding: menuItemParam.type == 'menu'
                        ? const EdgeInsets.fromLTRB(12, 8, 8, 8)
                        : const EdgeInsets.fromLTRB(6, 8, 8, 8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 50,
                          child: SvgPicture.asset(
                            menuItemParam.icon,
                            color: buttonTextColor,
                            semanticsLabel: menuItemParam.title,
                          ),
                        ),
                        Text(
                          menuItemParam.title,
                          style: TextStyle(
                            color: buttonTextColor,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: menuItemParam.label == 'soon'
                        ? Image.asset(
                            AppImages.comingSoonImage,
                            height: menuItemHeight,
                            width: menuItemHeight,
                          )
                        : Container(),
                  ),
                ],
              ),
            );
          })
        : (menuItemParam.type == 'menu')
            ? OnHoverButton(builder: (isHovered) {
                return GestureDetector(
                  onTap: () => _openTab(menuItemParam, gtmTab),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(6),
                        height: menuItemHeight,
                        child: SvgPicture.asset(
                          menuItemParam.icon,
                          color: Colors.white,
                          semanticsLabel: menuItemParam.title,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: menuItemParam.label == 'soon'
                            ? Image.asset(
                                AppImages.comingSoonImage,
                                height: collapsedMenuIconSize,
                              )
                            : Container(),
                      ),
                    ],
                  ),
                );
              })
            : Container();
  }

  Widget _buildTabs() {
    if (gtmTabLocalList.isNotEmpty) {
      return SizedBox(
        width: mainWidgetWidth,
        height: mainWidgetHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: tabBarHeight,
              width: mainWidgetWidth,
              alignment: Alignment.topLeft,
              child: TabBar(
                onTap: (tabIndex) {},
                controller: _tabController,
                labelPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                isScrollable: true,
                labelColor: AppColors.charcoalGrey,
                indicatorColor: AppColors.darkPurpleColor,
                tabs: gtmTabLocalList.map((e) => e.tab).toList(),
              ),
            ),
            Expanded(
              child: Container(
                width: mainWidgetWidth,
                alignment: Alignment.topLeft,
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: gtmTabLocalList.map((e) => e.page!).toList(),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  void _openTab(SideMenuItem menuItem, GtmTab gtmTab) async {
    if (gtmTab.shortname == TIMATIC) {
      timaticLaunchUrl();
    } else {
      if (menuItem.type == 'menu') {
        openTab(gtmTab, context);
        final int index = gtmTabLocalList
            .indexWhere((element) => element.name == gtmTab.name);
        final int _val = index >= 0 ? index : gtmTabLocalList.length - 1;
        _tripTabControllerIndexGet(_val);
      }
    }
  }

  void _tripTabControllerIndexGet(int val) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _tabController.index = val;
    activeTabId = val;
  }
}
