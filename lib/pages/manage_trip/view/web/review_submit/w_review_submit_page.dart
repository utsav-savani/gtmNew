import 'package:flutter/material.dart';
import 'package:gtm/_shared/libraries/app_alert.dart';
import 'package:gtm/_shared/libraries/app_loader.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/manage_trip/view/web/review_submit/_partials/trip_detail_widget.dart';
import 'package:gtm/pages/manage_trip/view/web/review_submit/_partials/trip_pob_widget.dart';
import 'package:gtm/pages/manage_trip/view/web/review_submit/_partials/trip_schedule_widget.dart';
import 'package:gtm/pages/manage_trip/view/web/review_submit/_partials/trip_service_widget.dart';
import 'package:gtm/pages/widgets/trip_accordion.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';
import 'package:timezone/browser.dart' as tz;

class WReviewSubmitPage extends StatefulWidget {
  final TabController? tabController;
  final String guid;
  const WReviewSubmitPage({
    Key? key,
    required this.tabController,
    required this.guid,
  }) : super(key: key);

  @override
  State<WReviewSubmitPage> createState() => _WReviewSubmitPageState();
}

class _WReviewSubmitPageState extends State<WReviewSubmitPage> {
  bool _isLoading = false;
  late TripManagerReview _review;
  late String _guid;

  @override
  void initState() {
    _guid = widget.guid;
    super.initState();
    // ignore: unnecessary_null_comparison
    if (_guid != null) _getTripReviewDetails();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  _getTripReviewDetails() async {
    _isLoading = true;
    _review =
        await TripManagerReviewRepository().getTripReviewDetails(guid: _guid);
    _isLoading = false;
    setState(() {});
    var detroit = tz.getLocation('America/Detroit');
    var america = tz.TZDateTime.now(detroit);
    print("America=> ${america.toString()}");
    var idetroit = tz.getLocation('Asia/Kolkata');
    var india = tz.TZDateTime.now(idetroit);
    print("India=> ${india.toString()}");
    detroit = tz.getLocation('Asia/Dubai');
    var uae = tz.TZDateTime.now(detroit);
    print("UAE=> ${uae.toString()}"); //"2020-07-02 10:00:00"

    var time = DateTime.parse("2022-05-05 15:00:00 Z");
    print(time);
    var qdetroit = tz.getLocation('Europe/London');
    print(qdetroit);
    var qat = tz.TZDateTime.from(time, qdetroit);
    print("London=> ${qat.toString()} \n \n");

    time = DateTime.parse("2022-11-01 03:50:00 Z");
    print(time);
    qdetroit = tz.getLocation('Australia/Sydney');
    print(qdetroit);
    qat = tz.TZDateTime.from(time, qdetroit);
    print("Sydney=> ${qat.toString()} \n \n");

    time = DateTime.parse("2022-05-01 03:50:00 Z");
    print(time);
    qdetroit = tz.getLocation('Australia/Sydney');
    print(qdetroit);
    qat = tz.TZDateTime.from(time, qdetroit);
    print("Sydney=> ${qat.toString()} \n \n");

    time = DateTime.parse("2022-11-06 05:00:00 Z");
    print(time);
    qdetroit = tz.getLocation('America/Los_Angeles');
    print(qdetroit);
    qat = tz.TZDateTime.from(time, qdetroit);
    print("Los_Angeles=> ${qat.toString()} \n \n");

    time = DateTime.parse("2022-11-08 05:00:00");
    print(time);
    var qqq = timezoneToLocalTime(time: time, timezone: 'America/Los_Angeles');
    print("Los_Angeles=> ${qqq.toString()} \n \n");
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return loadingWidget();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              //MARK:- This is to load the trip details
              _buildSectionHeaderWidget(
                title: "Trip Detail",
                index: 0,
                content: WReviewSubmitDetailWidget(review: _review),
              ),
              height(24),
              //MARK:- This is to load the trip schedule
              _buildSectionHeaderWidget(
                title: "Trip Schedule",
                index: 1,
                content: ReviewSubmitTripScheduleWidget(review: _review),
              ),
              height(24),
              //MARK:- This is to load the trip service
              _buildSectionHeaderWidget(
                title: "Trip Services",
                index: 2,
                content: ReviewSubmitTripServiceWidget(review: _review),
              ),
              height(24),
              //MARK:- This is to load the trip POB
              _buildSectionHeaderWidget(
                title: "People On Board(POB)",
                index: 3,
                content: ReviewSubmitTripPOBWidget(review: _review),
              ),
              height(24),
              Align(
                alignment: Alignment.centerRight,
                child: _buildReviewSubmitButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewSubmitButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () async {
          setState(() {});
          try {
            await AppLoader(context).show(title: "Submitting Trip Details...");
            await TripManagerReviewRepository().saveTripDetails(guid: _guid);
            await AppLoader(context).hide();
            AppAlert.show(
              context,
              title: 'Success',
              body: 'The Trip submitted successfully!!!',
              buttonTextCallback: () {
                if (widget.tabController != null) {
                  widget.tabController!.animateTo(0);
                }
              },
            );

            setState(() {});
          } catch (e) {
            //print(e);
          }
        },
        child: const Text('Submit'),
      ),
    );
  }

  Widget _buildSectionHeaderWidget({
    required String title,
    required Widget content,
    required int index,
  }) {
    return TripAccordion(
      visualDensity: -3,
      titleWidget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          appText(title, color: AppColors.whiteColor),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: underLineText(
                child: appText('Edit', color: AppColors.whiteColor),
                color: AppColors.whiteColor,
              ),
            ),
            onTap: () {
              widget.tabController!.animateTo(index);
            },
          ),
        ],
      ),
      listTileColor: AppColors.defaultColor,
      titleColor: AppColors.whiteColor,
      content: content,
    );
  }
}
