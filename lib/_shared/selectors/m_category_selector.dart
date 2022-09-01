import 'package:flight_category_repository/flight_category_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MCategorySelector extends StatefulWidget {
  final String customerId;
  final Function categorySelectHandler;

  const MCategorySelector(
      {Key? key, required this.customerId, required this.categorySelectHandler})
      : super(key: key);

  @override
  State<MCategorySelector> createState() => _MCategorySelectorState();
}

class _MCategorySelectorState extends State<MCategorySelector> {
  bool _isLoading = true;
  late List<FlightCategory> _categories = <FlightCategory>[];
  FlightCategory? _selectedCategory;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _isLoading = true;
    _categories = [];
    setState(() {});
    _getAllCategories();
    if (mounted) {
      setState(() {});
    }
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _getAllCategories();
    if (mounted) {
      setState(() {});
    }
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    _getAllCategories();
    super.initState();
  }

  void _getAllCategories() async {
    FlightCategoryRepository _repo = FlightCategoryRepository();
    try {
      _categories =
          await _repo.getFlightCategories(customerId: widget.customerId);
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
              "Select Flight Category",
              color: AppColors.defaultColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
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
                          shrinkWrap: true,
                          itemBuilder: (c, i) {
                            FlightCategory flightCategory = _categories[i];
                            return Card(
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 0,
                                ),
                                title: label(
                                  flightCategory.category,
                                  fontWeight: FontWeight.w600,
                                ),
                                onTap: () => _confirmSelector(flightCategory),
                              ),
                            );
                          },
                          itemCount: _categories.length,
                        ),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  void _confirmSelector(FlightCategory flightCategory) {
    _selectedCategory = flightCategory;
    widget.categorySelectHandler(_selectedCategory);
  }
}
