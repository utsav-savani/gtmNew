import 'dart:async';

import 'package:country_repository/country_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MCountrySelector extends StatefulWidget {
  final Function countrySelectHandler;
  const MCountrySelector({Key? key, required this.countrySelectHandler})
      : super(key: key);

  @override
  State<MCountrySelector> createState() => _MCountrySelectorState();
}

class _MCountrySelectorState extends State<MCountrySelector> {
  bool _isLoading = true;
  late List<Country> _countries = <Country>[];
  late List<Country> _allCountries = <Country>[];
  late ScrollController scollBarController;
  Country? _selectedCountry;
  String? _searchedString;
  Timer? _debounce;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final TextEditingController _searchController = TextEditingController();

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _isLoading = true;
    _countries = [];
    setState(() {});
    _getAllCountries();
    if (mounted) {
      setState(() {});
    }
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _getAllCountries();
    if (mounted) {
      setState(() {});
    }
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    _getAllCountries();
    super.initState();
  }

  void _getAllCountries() async {
    CountryRepository _repo = CountryRepository();
    try {
      _countries = await _repo.getCountries();
      _allCountries = _countries;
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
              "Select Country",
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
                  hintText: 'Search Country...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: () => _clearSearch(),
                    icon: const Icon(
                      Icons.highlight_off,
                      size: 16,
                    ),
                  ),
                ),
                textInputAction: TextInputAction.done,
                autocorrect: false,
                onChanged: _onSearchChanged,
              ),
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
                            Country country = _countries[i];
                            return Card(
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 0,
                                ),
                                title: label(
                                  "${country.name}",
                                  fontWeight: FontWeight.w600,
                                ),
                                onTap: () => _confirmSelector(country),
                              ),
                            );
                          },
                          itemCount: _countries.length,
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
    _searchCountry(null);
  }

  _onSearchChanged(String query) {
    _searchedString = query;
    setState(() {});
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchCountry(query);
    });
  }

  void _searchCountry(String? text) {
    if (text == null) return;
    _searchController.text = text;
    _searchedString = text;
    _countries = [];
    setState(() {});

    _countries = _allCountries.where((country) {
      final String _countryName = country.name!.toLowerCase();
      return _countryName.contains(text.toLowerCase());
    }).toList();
    setState(() {});
  }

  void _confirmSelector(Country country) {
    _selectedCountry = country;
    widget.countrySelectHandler(_selectedCountry);
    Navigator.pop(context);
  }
}
