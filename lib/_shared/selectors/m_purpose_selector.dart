import 'package:flight_purpose_repository/flight_purpose_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MPurposeSelector extends StatefulWidget {
  final Function purposeSelectHandler;
  const MPurposeSelector({Key? key, required this.purposeSelectHandler})
      : super(key: key);

  @override
  State<MPurposeSelector> createState() => _MPurposeSelectorState();
}

class _MPurposeSelectorState extends State<MPurposeSelector> {
  bool _isLoading = true;
  late List<FlightPurpose> _purposes = <FlightPurpose>[];
  late ScrollController scollBarController;
  FlightPurpose? _selectedFlightPurpose;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _isLoading = true;
    _purposes = [];
    setState(() {});
    _getAllPurposes();
    if (mounted) {
      setState(() {});
    }
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _getAllPurposes();
    if (mounted) {
      setState(() {});
    }
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    _getAllPurposes();
    super.initState();
  }

  void _getAllPurposes() async {
    FlightPurposeRepository _repo = FlightPurposeRepository();
    try {
      _purposes = await _repo.getFlightPurposesData();
      _isLoading = false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: false,
            leading: Container(),
            leadingWidth: 0,
            actions: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: AppColors.redColor),
                  ),
                ),
              ),
            ],
            title: label(
              "Select Flight Purpose",
              color: AppColors.defaultColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: MediaQuery.of(context).size.height - 120,
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  header: const WaterDropHeader(),
                  footer: CustomFooter(
                    builder: (BuildContext context, LoadStatus? mode) {
                      Widget body;
                      if (mode == LoadStatus.idle) {
                        body = const Text("Loading...");
                      } else if (mode == LoadStatus.loading) {
                        body = const CupertinoActivityIndicator();
                      } else if (mode == LoadStatus.failed) {
                        body = const Text("Load Failed!Click retry!");
                      } else if (mode == LoadStatus.canLoading) {
                        body = const Text("release to load more");
                      } else {
                        body = const Text("No more Data");
                      }
                      return SizedBox(
                        height: 55.0,
                        child: Center(child: body),
                      );
                    },
                  ),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: _isLoading
                      ? loadingWidget()
                      : ListView.builder(
                          itemBuilder: (c, i) {
                            FlightPurpose purpose = _purposes[i];
                            return Card(
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 0,
                                ),
                                title: label(
                                  purpose.flightPurpose,
                                  fontWeight: FontWeight.w600,
                                ),
                                onTap: () => _confirmSelector(purpose),
                              ),
                            );
                          },
                          itemCount: _purposes.length,
                        ),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  void _confirmSelector(FlightPurpose purpose) {
    _selectedFlightPurpose = purpose;
    widget.purposeSelectHandler(_selectedFlightPurpose);
  }
}
