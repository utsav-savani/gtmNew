import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/drawer/m_app_drawer_screen.dart';
import 'package:gtm/pages/home/dashboard/bloc/trips/trip_bloc.dart';
import 'package:gtm/pages/home/dashboard/bloc/trips/trip_statistics_bloc.dart';
import 'package:gtm/pages/home/dashboard/dashboard_event.dart';
import 'package:gtm/pages/home/view/mobile/_partials/create_trip_modal_widget.dart';
import 'package:gtm/pages/home/dashboard/view/mobile/_partials/trip_manager_advance_filter_widget.dart';
import 'package:gtm/pages/home/dashboard/view/mobile/_partials/trip_manager_analytics_widget.dart';
import 'package:gtm/pages/home/dashboard/view/mobile/_partials/trip_manager_list_widget.dart';

class MTripManagerLandingScreen extends StatefulWidget {
  const MTripManagerLandingScreen({Key? key}) : super(key: key);

  @override
  State<MTripManagerLandingScreen> createState() =>
      _MTripManagerLandingScreenState();
}

class _MTripManagerLandingScreenState extends State<MTripManagerLandingScreen> {
  int index = 0;
  bool _showSearchFiled = false;
  final bool _isLoading = false;

  late TripBloc tripBloc;
  late TripStatisticBloc tripStatisticBloc;

  // @override
  // void setState(fn) {
  //   if (mounted) {
  //     super.setState(fn);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    tripBloc = BlocProvider.of(context);
    tripStatisticBloc = BlocProvider.of(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      drawer: const MAppDrawerScreen(),
      appBar: CustomBasicAppBar(title: "Trip Manager", actions: [
        IconButton(
          onPressed: () {
            _showSearchFiled = !_showSearchFiled;
            setState(() {});
          },
          icon: svgToIcon(
            appImagesName: AppImages.searchIcon,
            color: AppColors.greyishBrown,
          ),
        ),
      ]),
      body: SingleChildScrollView(
        child: _isLoading
            ? loadingWidget()
            : Column(
                children: [
                  if (_showSearchFiled)
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 0,
                            color: AppColors.brownGrey,
                            offset: Offset(0, 0.2),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _builSearchFieldWidget(),
                      ),
                    ),
                  const TripManagerAnalyticsWidget(),
                  const TripManagerListWidget(),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: svgToIcon(
          appImagesName: AppImages.addIcon,
          color: AppColors.whiteColor,
        ),
        onPressed: () => _createTripModalSheet(),
      ),
    );
  }

  Widget _builSearchFieldWidget() {
    TextEditingController _searchTextController = TextEditingController();

    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _searchTextController,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              hintText: "Search",
              prefixIconConstraints: const BoxConstraints(
                minWidth: 23,
                maxHeight: 20,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: svgToIcon(
                  appImagesName: AppImages.searchIcon,
                  color: AppColors.blueGrey,
                ),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  _searchTextController.clear();
                  tripBloc.add(const SearchTrips(searchText: ''));
                  tripStatisticBloc.add(const SearchTrips(searchText: ''));
                },
                icon: const Icon(Icons.clear_rounded),
              ),
            ),
            onFieldSubmitted: (searchText) {
              tripBloc.add(SearchTrips(searchText: searchText));
              tripStatisticBloc.add(SearchTrips(searchText: searchText));
            },
          ),
        ),
        width(20),
        InkWell(
          onTap: () => _buildAdvancedFilter(),
          child: underLineText(
            child: appText("Advanced"),
          ),
        ),
      ],
    );
  }

  void _createTripModalSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const CreateTripModalWidget();
      },
    );
    // tripBloc.add(const FetchTrips());
    // tripStatisticBloc.add(const FetchTripStatistics());
  }

  void _buildAdvancedFilter() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const TripManagerAdvanceFilterWidget();
      },
    );
  }
}
