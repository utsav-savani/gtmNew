import 'dart:async';

class Debounce {
  Timer? _debounce;

  String onSearchChanged(String query) {
    String qry = '';
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 3000), () {
      qry = query;
    });
    return qry;
  }

  void dispose() {
    _debounce?.cancel();
  }
}
