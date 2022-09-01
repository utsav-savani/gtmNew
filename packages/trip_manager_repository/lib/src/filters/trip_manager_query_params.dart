class TripManagerQuery {
  final int? page;
  final int? limit;
  final int? aircraftId;
  final String? search;
  final String? fromDate;
  final String? toDate;
  final String? filtersType;
  final List<int>? customerId;
  final List<Map<String, dynamic>>? offices;
  final String? status;

  TripManagerQuery({
    this.page,
    this.limit,
    this.aircraftId,
    this.search,
    this.fromDate,
    this.toDate,
    this.customerId,
    this.offices,
    this.filtersType,
    this.status,
  });

  Map<String, dynamic> toJson() => {
        'page': page ?? null,
        "limit": limit,
        "aircraftId": aircraftId,
        "search": search,
        "fromDate": fromDate,
        "customerId": customerId,
        "offices": offices,
        "endDate": toDate,
        "filterTypes": filtersType,
        "isGTM": true,
        "status": status,
      };
}
