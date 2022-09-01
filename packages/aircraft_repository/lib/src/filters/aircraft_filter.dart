class AircraftFilter {
  String? _page;
  String? _limit;
  String? _search;
  String? _customerId;
  String? _aircraftId;

  void setPage(page) => _page = page;
  void setLimit(limit) => _limit = limit;
  void setCustomerId(customerId) => _customerId = customerId.toString();
  void setAircraftId(aircraftId) => _aircraftId = aircraftId.toString();
  void setSearch(search) => _search = search;

  String? page() => _page ?? null;
  String? limit() => _limit ?? null;
  String? customerId() => _customerId ?? null;
  String? aircraftId() => _aircraftId ?? null;
  String? search() => _search ?? null;
}
