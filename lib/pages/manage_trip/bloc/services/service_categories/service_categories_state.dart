import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:service_category_repository/service_category_repository.dart';

enum FetchServiceCategoriesState { initial, loading, success, failure }

class ServiceCategoriesState extends Equatable {
  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  final FetchServiceCategoriesState status;
  final List<ServiceCategory> serviceCategories;
  final String equalityChecker;
  final bool isListUnderSearch;

  ServiceCategoriesState({
    this.status = FetchServiceCategoriesState.initial,
    this.serviceCategories = const [],
    this.equalityChecker = '',
    this.isListUnderSearch = false,
  });

  ServiceCategoriesState copyWith({
    FetchServiceCategoriesState? status,
    required List<ServiceCategory> serviceCategories,
    required bool isListUnderSearch,
  }) {
    return ServiceCategoriesState(
      status: status ?? this.status,
      serviceCategories: serviceCategories,
      isListUnderSearch: isListUnderSearch,
      equalityChecker: getRandomString(16),
    );
  }

  @override
  List<Object?> get props => [status, serviceCategories, isListUnderSearch, equalityChecker];
}
