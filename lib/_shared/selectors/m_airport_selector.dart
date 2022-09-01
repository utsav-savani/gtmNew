import 'dart:async';

import 'package:airport_repository/airport_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MAirportSelector extends StatefulWidget {
  final Function airportSelectHandler;
  const MAirportSelector({Key? key, required this.airportSelectHandler})
      : super(key: key);

  @override
  State<MAirportSelector> createState() => _MAirportSelectorState();
}

class _MAirportSelectorState extends State<MAirportSelector> {
  bool _isLoading = true;
  late List<Airport> _airports = <Airport>[];
  late ScrollController scollBarController;
  Airport? _selectedAirport;
  AirportsListFilter _filter = AirportsListFilter();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final TextEditingController _searchController = TextEditingController();
  String? _searchedString;
  Timer? _debounce;

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _filter.setPage("0");
    _isLoading = true;
    _airports = [];
    setState(() {});
    _getAllAirports(_filter);
    if (mounted) {
      setState(() {});
    }
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 500));
    int page = int.parse(_filter.page());
    _filter.setPage("$page");
    _getAllAirports(_filter);
    if (mounted) {
      setState(() {});
    }
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    _filter = AirportsListFilter();
    _filter.setLimit("20");
    _filter.setPage("0");
    _getAllAirports(_filter);
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _getAllAirports(filter) async {
    AirportRepository _repo = AirportRepository();
    try {
      final res = await _repo.getAirports(filter: filter);
      if (_filter.page() == 1) {
        _airports = res;
      } else {
        _airports.addAll(res);
      }
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
    _searchController.text = _searchedString ?? '';

    _searchController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: _searchController.text.length,
      ),
    );
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
              "Select Airport",
              color: AppColors.defaultColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            bottom: AppBar(
              elevation: 0,
              leading: Container(),
              leadingWidth: 0,
              title: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Airport...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: () => _clearSearch(),
                    icon: const Icon(
                      Icons.highlight_off,
                      size: 16,
                    ),
                  ),
                ),
                onChanged: _onSearchChanged,
                textInputAction: TextInputAction.search,
                autocorrect: false,
                onSubmitted: (val) => _searchAirport(val),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: MediaQuery.of(context).size.height - 120,
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
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
                            Airport airport = _airports[i];
                            String _airportName =
                                "(${airport.icao}/${airport.iata}) ${airport.name}";
                            if (airport.city != null &&
                                airport.city != "null" &&
                                airport.city != "") {
                              _airportName = "$_airportName, ${airport.city}";
                            }
                            return Card(
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 0,
                                ),
                                title: label(
                                  _airportName,
                                  fontWeight: FontWeight.w600,
                                ),
                                subtitle: Text("${airport.countryName}"),
                                onTap: () => _confirmSelector(airport),
                              ),
                            );
                          },
                          itemCount: _airports.length,
                        ),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  void _clearSearch() {
    _searchController.clear();
    _searchAirport(null);
  }

  _onSearchChanged(String query) {
    _searchedString = query;
    setState(() {});
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchAirport(query);
    });
  }

  void _searchAirport(String? text) {
    if (text != null) _searchController.text = text;
    _filter.setSearch(text);
    _filter.setPage("0");
    _airports = [];
    _isLoading = true;
    setState(() {});
    _getAllAirports(_filter);
  }

  void _confirmSelector(Airport airport) {
    _selectedAirport = airport;
    widget.airportSelectHandler(_selectedAirport);
  }
}
