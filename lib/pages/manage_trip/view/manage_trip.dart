import 'package:flutter/material.dart';
import 'package:gtm/_shared/constants/string_constants.dart';
import 'package:gtm/_shared/widgets/_common/w_common_tripbar.dart';
import 'package:gtm/_shared/widgets/_common/widget_size.dart';
import 'package:gtm/_shared/widgets/custom_widgets.dart';
import 'package:gtm/pages/home/view/trip_detail_landing_screen.dart';
import 'package:gtm/pages/home/view/web/components/tab_functions.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/trip_details_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/trip_details_event.dart';
import 'package:gtm/pages/manage_trip/bloc/trip_data/trip_details/trip_details_state.dart';
import 'package:gtm/pages/manage_trip/view/web/review_submit/w_review_submit_page.dart';
import 'package:gtm/pages/manage_trip/view/web/sevices/w_services_page.dart';
import 'package:gtm/pages/manage_trip/view/web/trip_data/trip_data.dart';
import 'package:gtm/pages/manage_trip/view/web/w_documents_page.dart';
import 'package:gtm/pages/manage_trip/view/web/w_pob/w_pob_page.dart';
import 'package:gtm/pages/manage_trip/view/web/w_schedule/w_schedule_list_screen.dart';
import 'package:gtm/responsive/screen_type_layout.dart';
import 'package:gtm/theme/app_colors.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class ManageTrip extends StatefulWidget {
  final String guid;

  const ManageTrip({
    Key? key,
    required this.guid,
  }) : super(key: key);

  @override
  State<ManageTrip> createState() => _ManageTripState();
}

class _ManageTripState extends State<ManageTrip> with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linearToEaseOut,
    );
  }

  @override
  void didChangeDependencies() {
    fetchTripMangerDetails();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: _buildMobile(context),
      tablet: _buildWeb(context),
      desktop: _buildWeb(context),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Widget _buildMobile(BuildContext context) =>
      TripDetailLandingScreen(guid: widget.guid);

  Widget _buildWeb(BuildContext context) {
    bool isTripBarVisible = false;
    return Scaffold(
      body: BlocBuilder<TripDetailsBloc, FetchTripDetailsState>(
        builder: (context, state) {
          switch (state.status) {
            case FetchTripDetailsStatus.initial:
            case FetchTripDetailsStatus.loading:
              return Center(child: CustomWidgets().buildCircularProgress());
            case FetchTripDetailsStatus.success:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        _buildManageTripTextWeb(),
                        Expanded(
                          child: _buildWebTabBar(),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            closeTab(
                                state.tripDetail.tripNumber != null
                                    ? "Trip: " +
                                        state.tripDetail.tripNumber.toString()
                                    : 'New Trip',
                                context);
                          },
                          child: const Text('Exit'),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.redColor)),
                        ),
                      ],
                    ),
                  ),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizeTransition(
                            child: CommonTripBar(
                              tripDetail: state.tripDetail,
                              onHeaderVisibilityChange: (bool) {},
                            ),
                            sizeFactor: _animation,
                            axis: Axis.vertical,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child: Divider(
                                  height: 1,
                                  color: AppColors.defaultColor,
                                ),
                                flex: 90,
                              ),
                              Expanded(
                                flex: 8,
                                child: StatefulBuilder(
                                  builder: (context, setState) {
                                    return InkWell(
                                      onTap: () {
                                        if (_animation.status !=
                                            AnimationStatus.completed) {
                                          _controller.forward();
                                        } else {
                                          _controller.animateBack(0,
                                              duration: const Duration(
                                                  milliseconds: 500));
                                        }
                                        setState(() => isTripBarVisible =
                                            !isTripBarVisible);
                                      },
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 1,
                                              bottom: 1),
                                          child: Icon(
                                            isTripBarVisible
                                                ? Icons
                                                    .keyboard_arrow_up_outlined
                                                : Icons
                                                    .keyboard_arrow_down_outlined,
                                            color: Colors.white,
                                          ),
                                        ),
                                        decoration: const BoxDecoration(
                                          color: AppColors.defaultColor,
                                          border: Border(
                                            left: BorderSide(
                                              color: AppColors.defaultColor,
                                              width: 1,
                                            ),
                                            right: BorderSide(
                                                color: AppColors.defaultColor,
                                                width: 1),
                                            bottom: BorderSide(
                                                color: AppColors.defaultColor,
                                                width: 1),
                                          ),
                                          //borderRadius: BorderRadius.only(bottomRight: Radius.circular(4), bottomLeft: Radius.circular(4)),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const Expanded(
                                child: Divider(
                                  height: 1,
                                  color: AppColors.defaultColor,
                                ),
                                flex: 2,
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ],
                      );
                    },
                  ),
                  Expanded(child: _buildTabBarViewWeb(state.tripDetail)),
                ],
              );
            case FetchTripDetailsStatus.failure:
              return _buildErrorWidget();
          }
        },
      ),
    );
  }

  Widget _buildWebTabBar() {
    return TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: spacing4,
        indicatorColor: AppColors.defaultColor,
        isScrollable: true,
        physics: const NeverScrollableScrollPhysics(),
        labelColor: AppColors.defaultColor,
        unselectedLabelStyle: const TextStyle(color: AppColors.powderBlue),
        unselectedLabelColor: AppColors.powderBlue,
        padding: const EdgeInsets.all(spacing4),
        tabs: [
          _buildTabItemWeb(tripData),
          _buildTabItemWeb(schedule),
          _buildTabItemWeb(services),
          _buildTabItemWeb(pob),
          _buildTabItemWeb(documents),
          _buildTabItemWeb("Review"),
        ]);
  }

  Widget _buildTabItemWeb(String title) {
    return Tab(text: title);
  }

  Widget _buildTabBarViewWeb(TripDetail tripDetail) {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: [
        TripData(tripDetail: tripDetail),
        WScheduleListScreen(tripDetail: tripDetail),
        WServicesPage(tripDetail: tripDetail, manageTripGuid: widget.guid),
        WPOBPage(tripDetail: tripDetail, guid: widget.guid),
        WDocumentsPage(guid: widget.guid),
        WReviewSubmitPage(tabController: _tabController, guid: widget.guid),
      ],
    );
  }

  Widget _buildManageTripTextWeb() {
    return const Text(
      manageTripText,
      style: TextStyle(
        fontSize: spacing36,
        fontWeight: FontWeight.w900,
        color: AppColors.powderBlue,
      ),
    );
  }

  Widget _buildErrorWidget() {
    return const Center(
      child: Text('Internal Error occurred'),
    );
  }

  fetchTripMangerDetails() {
    TripDetailsBloc tripDetailsBloc = BlocProvider.of<TripDetailsBloc>(context);
    tripDetailsBloc.add(FetchTripDetails(guid: widget.guid));
  }
}
