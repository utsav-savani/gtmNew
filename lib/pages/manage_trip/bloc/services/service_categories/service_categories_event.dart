import 'package:equatable/equatable.dart';

abstract class ServiceCategoriesEvent extends Equatable {
  const ServiceCategoriesEvent();

  @override
  List<Object> get props => [];
}

class FetchServiceCategories extends ServiceCategoriesEvent {
  const FetchServiceCategories();

  @override
  List<Object> get props => [];
}

class SearchServiceCategories extends ServiceCategoriesEvent {
  final String searchText;

  const SearchServiceCategories({this.searchText = ''});

  @override
  List<Object> get props => [searchText];
}

class UpdateAvailableServices extends ServiceCategoriesEvent {
  final int serviceID;
  final bool isSelected;

  const UpdateAvailableServices(this.serviceID, this.isSelected);

  @override
  List<Object> get props => [serviceID, isSelected];
}
