import 'package:gtm/pages/manage_trip/bloc/services/service_categories/service_categories_event.dart';
import 'package:gtm/pages/manage_trip/bloc/services/service_categories/service_categories_state.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_bloc.dart';
import 'package:service_category_repository/service_category_repository.dart';
import 'package:service_category_repository/src/models/category_detail_service.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class ServiceCategoriesBloc
    extends Bloc<ServiceCategoriesEvent, ServiceCategoriesState> {
  final ServiceCategoryRepository _serviceCategoriesRepository;
  List<ServiceCategory> serviceCategories = [];
  List<ServiceCategory> searchList = [];
  List<int?> selectedServiceIDs = [];
  List<CategoryDetailService> allServiceList = [];

  ServiceCategoriesBloc(
      {required ServiceCategoryRepository tripMangerRepository})
      : _serviceCategoriesRepository = tripMangerRepository,
        super(ServiceCategoriesState()) {
    on<FetchServiceCategories>(_getServiceCategories);
    on<SearchServiceCategories>(_searchServiceCategories);
    on<UpdateAvailableServices>(_updateSelectedServiceList);
  }

  Future<void> _getServiceCategories(
    ServiceCategoriesEvent event,
    Emitter<ServiceCategoriesState> emit,
  ) async {
    emit(state.copyWith(
        status: FetchServiceCategoriesState.loading,
        serviceCategories: [],
        isListUnderSearch: false));
    try {
      final serviceCategories =
          await _serviceCategoriesRepository.getServiceCategories();
      this.serviceCategories.clear();
      this.serviceCategories.addAll(serviceCategories);
      emit(state.copyWith(
          status: FetchServiceCategoriesState.success,
          serviceCategories: serviceCategories,
          isListUnderSearch: false));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(
          status: FetchServiceCategoriesState.failure,
          serviceCategories: [],
          isListUnderSearch: false));
    }
  }

  Future<void> _searchServiceCategories(
    ServiceCategoriesEvent event,
    Emitter<ServiceCategoriesState> emit,
  ) async {
    try {
      SearchServiceCategories searchServiceCategories =
          event as SearchServiceCategories;
      String searchText = searchServiceCategories.searchText.toLowerCase();
      if (searchText.isEmpty) {
        emit(state.copyWith(
            status: FetchServiceCategoriesState.success,
            serviceCategories: serviceCategories,
            isListUnderSearch: false));
        return;
      }
      searchList.clear();
      searchCategories(serviceCategories, searchText);
      emit(state.copyWith(
          status: FetchServiceCategoriesState.success,
          serviceCategories: searchList,
          isListUnderSearch: true));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(
          status: FetchServiceCategoriesState.failure,
          serviceCategories: [],
          isListUnderSearch: true));
    }
  }

  void loadAllService(List<ServiceCategory> serviceCategories) {
    serviceCategories.map((e) {
      allServiceList.addAll(e.service ?? []);
      loadAllService(e.childServiceCategory ?? []);
    }).toList();
  }

  List<TripService> getSelectedServices() {
    allServiceList.clear();
    loadAllService(serviceCategories);
    List<TripService> selectedServices = [];
    for (CategoryDetailService catService in allServiceList) {
      if (selectedServiceIDs.contains(catService.serviceId)) {
        selectedServices.add(
          TripService(
            serviceStatus: TripServiceBloc.newService,
            status: TripServiceBloc.serviceStatusNew,
            scheduleStatus: TripServiceBloc.original,
            serviceId: catService.serviceId,
            service: catService.name,
            isRemovable: true,
          ),
        );
      }
    }
    return selectedServices;
  }

  Future<void> _updateSelectedServiceList(
    ServiceCategoriesEvent event,
    Emitter<ServiceCategoriesState> emit,
  ) async {
    try {
      UpdateAvailableServices searchServiceCategories =
          event as UpdateAvailableServices;
      if (selectedServiceIDs.contains(searchServiceCategories.serviceID)) {
        if (!searchServiceCategories.isSelected) {
          selectedServiceIDs.remove(searchServiceCategories.serviceID);
        }
      } else {
        selectedServiceIDs.add(searchServiceCategories.serviceID);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void searchCategories(List<ServiceCategory> list, String searchText) {
    for (ServiceCategory element in list) {
      if (element.service != null) {
        List<CategoryDetailService> services = element.service!
            .where((element) => element.name.toLowerCase().contains(searchText))
            .toList();
        if (services.isNotEmpty) {
          addToSearchList(element, services);
        }
      }
      if (element.childServiceCategory != null) {
        searchCategories(element.childServiceCategory ?? [], searchText);
      }
    }
  }

  void addToSearchList(
      ServiceCategory category, List<CategoryDetailService> services) {
    int index = searchList.indexWhere(
        (element) => element.serviceCategoryId == category.serviceCategoryId);
    if (index == -1) {
      category = category.copyWith(
        serviceCategoryId: category.serviceCategoryId,
        name: category.name,
        service: services,
        childServiceCategory: category.childServiceCategory,
        serviceCategoryParentId: category.serviceCategoryParentId,
      );
      searchList.add(category);
    } else {
      searchList[index] = category.copyWith(
        serviceCategoryId: category.serviceCategoryId,
        name: category.name,
        service: services,
        childServiceCategory: category.childServiceCategory,
        serviceCategoryParentId: category.serviceCategoryParentId,
      );
    }
  }
}
