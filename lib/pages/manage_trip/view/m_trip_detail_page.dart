import 'package:flutter/material.dart';
import 'package:gtm/pages/manage_trip/view/mobile/m_pob_list_tab.dart';
import 'package:gtm/pages/manage_trip/view/mobile/m_documents_tab.dart';
import 'package:gtm/pages/manage_trip/view/mobile/m_review_submit_tab.dart';
import 'package:gtm/pages/manage_trip/view/mobile/m_schedule_tab.dart';
import 'package:gtm/pages/manage_trip/view/mobile/m_service_tab.dart';
import 'package:gtm/pages/manage_trip/view/web/trip_data/trip_data.dart';
import 'package:gtm/theme/app_colors.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class MTripDetailWidget extends StatefulWidget {
  final TripDetail tripDetail;
  const MTripDetailWidget({Key? key, required this.tripDetail})
      : super(key: key);

  @override
  State<MTripDetailWidget> createState() => _MTripDetailWidgetState();
}

class _MTripDetailWidgetState extends State<MTripDetailWidget>
    with SingleTickerProviderStateMixin {
  late TripDetail tripDetail;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  void didChangeDependencies() {
    tripDetail = widget.tripDetail;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color: AppColors.brownGrey.withOpacity(0.24),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: AppColors.defaultColor,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.blueGrey,
              tabs: [
                _buildTabHeader(title: 'Trip Data'),
                _buildTabHeader(title: 'Schedule'),
                _buildTabHeader(title: 'Services'),
                _buildTabHeader(title: 'POB'),
                _buildTabHeader(title: 'Documents'),
                _buildTabHeader(title: 'Review'),
              ],
            ),
          ),
        ),
        // tab bar view here
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              TripData(tripDetail: tripDetail),
              MScheduleTab(tripDetail: tripDetail),
              MServiceTab(tripDetail: tripDetail),
              MPobListTab(guid: tripDetail.guid!),
              MDocumentsTab(guid: tripDetail.guid!),
              MReviewSubmitTab(guid: tripDetail.guid!),
            ],
          ),
        ),
      ],
    );
  }

  _buildTabHeader({required String title}) {
    return Tab(
      text: title,
      height: 28,
    );
  }
}
