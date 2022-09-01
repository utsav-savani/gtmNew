class CompanyFilter {
  String? _page;
  String? _limit;
  String? _search;
  List<int>? _customerIdList;

  void setPage(page) => _page = page;
  void setLimit(limit) => _limit = limit;
  void setCustomerId(customerId) => _customerIdList!.first = _customerIdList!.first;
  void setSearch(search) => _search = search;

  String? page() => _page ?? null;
  String? limit() => _limit ?? null;
  List<int>? customerIdList() => _customerIdList ?? null;
  String? search() => _search ?? null;
}
