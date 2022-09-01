import 'package:flutter/foundation.dart';
import 'package:trip_manager_repository/src/filters/trip_manager_query_params.dart';

class TripManagerFilter {
  int? _page;
  int? _limit;
  String? _searchBy;
  String? _search;
  String? _fromDate;
  String? _toDate;
  List<int>? _customerIds;
  int? _aircraftId;
  List<int>? _offices;
  String? _filterTypes;
  String? _status;

  void setPage(page) => _page = page;

  void setLimit(limit) => _limit = limit;

  void setSearchBy(searchBy) => _searchBy = searchBy;

  void setSearch(search) => _search = search;

  void setFromDate(fromDate) => _fromDate = fromDate;

  void setToDate(toDate) => _toDate = toDate;

  void setCustomerIds(customerIds) => _customerIds = customerIds;

  void setAircraftId(aircraftId) => _aircraftId = aircraftId;

  void setOfficeIds(offices) => _offices = offices;

  void setFilterTypes(filterTypes) => _filterTypes = filterTypes;

  void setStatus(status) => _status = status;

  page() => _page;

  limit() => _limit;

  searchBy() => _searchBy;

  searchString() => _search;

  fromDate() => _fromDate;

  toDate() => _toDate;

  customerIds() => _customerIds;

  aircraftId() => _aircraftId;

  officeIds() => _offices;

  status() => _status;

  clear() {
    setPage(null);
    setLimit(null);
    setSearchBy(null);
    setSearch(null);
    setFromDate(null);
    setToDate(null);
    setCustomerIds(null);
    setAircraftId(null);
    setOfficeIds(null);
    setFilterTypes(null);
    setStatus(null);
  }

  Map<String, dynamic> paramsPayload(TripManagerFilter filter) {
    List<Map<String, dynamic>>? __offices = [];
    for (var _officeId in filter.officeIds()) {
      __offices.add({"officeId": _officeId});
    }

    var query = TripManagerQuery(
      page: filter.page() ?? null,
      limit: filter.limit() ?? null,
      aircraftId: filter.aircraftId() ?? null,
      search: filter.searchString() ?? null,
      customerId: filter.customerIds() ?? [],
      offices: __offices,
      fromDate: filter.fromDate(),
      toDate: filter.toDate(),
      status: filter.status(),
      filtersType: filter._filterTypes,
    ).toJson();

    debugPrint(query.values.toString());

    return query;
  }
}
