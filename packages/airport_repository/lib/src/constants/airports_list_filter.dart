class AirportsListFilter {
  String? _page;
  String? _limit;
  String? _search;
  String? _countryId;
  String? _airportId;

  void setPage(page) => _page = page;
  void setSearch(search) =>
      _search = search != null ? search.toString().trim() : null;
  void setLimit(limit) => _limit = limit;
  void setCountryId(countryId) => _countryId = countryId;
  void setAirportId(airportId) => _airportId = airportId;

  page() => _page;
  limit() => _limit;
  search() => _search;
  countryId() => _countryId;
  airportId() => _airportId;
}
