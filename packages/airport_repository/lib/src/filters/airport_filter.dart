class AirportFilter {
  String? _page;
  String? _limit;

  void setPage(page) => _page = page;
  void setLimit(limit) => _limit = limit;

  String? page() => _page ?? null;
  String? limit() => _limit ?? null;
}
