import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_tree/flutter_tree.dart' as tree;
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:gtm/_shared/helpers/app_helper.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/custom_widgets.dart';
import 'package:gtm/pages/manage_trip/bloc/services/service_categories/service_categories_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/service_categories/service_categories_event.dart';
import 'package:gtm/pages/manage_trip/bloc/services/service_categories/service_categories_state.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/save_service_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_event.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_state.dart';
import 'package:gtm/pages/manage_trip/view/web/sevices/_partials/service_data_source.dart';
import 'package:gtm/pages/manage_trip/view/web/sevices/_partials/service_extensions.dart';
import 'package:gtm/pages/manage_trip/view/web/sevices/_partials/service_form_submit_buttons.dart';
import 'package:gtm/pages/manage_trip/view/web/sevices/_partials/service_legends_widget.dart';
import 'package:gtm/pages/manage_trip/view/web/sevices/w_airport_flight_requirements_popup.dart';
import 'package:service_category_repository/service_category_repository.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class WServicesPage extends StatefulWidget {
  const WServicesPage({
    Key? key,
    required this.manageTripGuid,
    required this.tripDetail,
  }) : super(key: key);
  final TripDetail? tripDetail;
  final String manageTripGuid;

  @override
  State<WServicesPage> createState() => _WServicesPageState();
}

class _WServicesPageState extends State<WServicesPage> {
  late TripServiceMain _tripServiceMain;
  ScrollController listController = ScrollController();
  ScrollController gridScrollController = ScrollController();
  bool isGridScrolled = false, isListScrolled = false;
  late TripServiceBloc tripServiceBloc;
  ValueNotifier<bool> isUTC = ValueNotifier(true);
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    gridScrollController.addListener(() {
      if (isListScrolled) {
        return;
      }
      isGridScrolled = true;
      double scrollOffset = gridScrollController.offset;
      final double l1maxHeight = gridScrollController.position.maxScrollExtent;
      final double l2maxHeight = listController.position.maxScrollExtent;
      double jumpPoss = (math.min(l1maxHeight, l2maxHeight) * scrollOffset) /
          math.max(l1maxHeight, l2maxHeight);
      listController.jumpTo((jumpPoss));
      isGridScrolled = false;
    });
    listController.addListener(() {
      if (isGridScrolled) {
        return;
      }
      isListScrolled = true;
      double scrollOffset = listController.offset;
      final double l1maxHeight = gridScrollController.position.maxScrollExtent;
      final double l2maxHeight = listController.position.maxScrollExtent;
      double jumpPoss = (math.min(l1maxHeight, l2maxHeight) * scrollOffset) /
          math.max(l1maxHeight, l2maxHeight);
      gridScrollController.jumpTo((jumpPoss));
      isListScrolled = false;
    });
  }

  @override
  void didChangeDependencies() {
    tripServiceBloc = BlocProvider.of(context);
    fetchTripService();
    super.didChangeDependencies();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void fetchTripService() {
    tripServiceBloc.editMode = false;
    tripServiceBloc = BlocProvider.of(context);
    tripServiceBloc.add(FetchTripService(guid: widget.manageTripGuid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TripServiceBloc, TripServiceState>(
        builder: (BuildContext context, TripServiceState state) {
          switch (state.status) {
            case FetchTripServiceStatus.initial:
            case FetchTripServiceStatus.loading:
              return loadingWidget();
            case FetchTripServiceStatus.success:
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColors.blueGrey),
                      ),
                    ),
                    child: Row(
                      children: [
                        width(24),
                        label(
                          "Services",
                          color: AppColors.brownGrey,
                          fontSize: 24,
                        ),
                        width(24),
                        if (!tripServiceBloc.editMode)
                          ElevatedButton(
                            onPressed: () {
                              tripServiceBloc.add(EditServices());
                              setState(() {});
                            },
                            child:
                                BlocBuilder<SaveServiceBloc, SaveServiceState>(
                              builder: (context, state) {
                                switch (state) {
                                  case SaveServiceState.loading:
                                  case SaveServiceState.initial:
                                  case SaveServiceState.success:
                                  case SaveServiceState.failure:
                                    if (!tripServiceBloc.editMode) {
                                      return const Text('Edit');
                                    }
                                    return Container();
                                }
                              },
                            ),
                          ),
                        width(24),
                        ValueListenableBuilder<bool>(
                          builder: (context, value, child) {
                            return CustomWidgets().buildUTCToLocalSwitch(
                              onChanged: (value) {
                                isUTC.value = value;
                              },
                              value: value,
                            );
                          },
                          valueListenable: isUTC,
                        ),
                        const Spacer(),
                        const TripServiceLegends(),
                      ],
                    ),
                  ),
                  height(8),
                  Flexible(
                    child: _buildServicesWidget(state.tripServiceMain),
                  ),
                  if (tripServiceBloc.editMode)
                    TripServiceFormSubmitButtonsWidget(
                      state: state,
                      context: context,
                      fetchTripService: fetchTripService,
                      guid: widget.manageTripGuid,
                      tripServiceBloc: tripServiceBloc,
                      updateSetstate: () => setState(() {}),
                    ),
                ],
              );
            case FetchTripServiceStatus.failure:
              return noDataFoundWidget();
            case FetchTripServiceStatus.idle:
              return Container();
          }
        },
      ),
    );
  }

  Widget _buildServiceList(TripServiceMain tripService) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: ListView.builder(
            //physics: const NeverScrollableScrollPhysics(),
            controller: listController,
            itemCount: tripService.services!.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              bool isAlternateItem = index % 2 == 0;
              BoxDecoration? _boxDecoration;
              if (isAlternateItem) {
                _boxDecoration = const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-1, 0),
                    end: Alignment(1, 0),
                    colors: [
                      Color.fromRGBO(141, 141, 141, 0.1),
                      Color.fromRGBO(248, 248, 248, 0),
                    ],
                  ),
                );
              }
              return Container(
                height: spacing44,
                decoration: _boxDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      child: Text(
                        tripService.services![index].service ?? '',
                        overflow: TextOverflow.ellipsis,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 20,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_vert_rounded,
                        color: AppColors.brownGrey,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildServiceSelector(TripServiceMain tripService) {
    ServiceCategoriesBloc serviceCategoriesBloc = BlocProvider.of(context);
    serviceCategoriesBloc.selectedServiceIDs =
        (tripService.services ?? []).map((e) => e.serviceId).toList();
    late TreeViewController _treeViewController;
    return BlocBuilder<ServiceCategoriesBloc, ServiceCategoriesState>(
      builder: (context, state) {
        switch (state.status) {
          case FetchServiceCategoriesState.initial:
          case FetchServiceCategoriesState.loading:
            return loadingWidget();
          case FetchServiceCategoriesState.success:
            _treeViewController = TreeViewController(
                children: _getNodeList(state.serviceCategories));
            return StatefulBuilder(
              builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: TreeView(
                        shrinkWrap: true,
                        controller: _treeViewController,
                        nodeBuilder: (context, Node node) {
                          if (node.children.isNotEmpty) {
                            return ListTile(
                              title: Text(node.label),
                            );
                          }
                          return CheckboxListTile(
                            value: node.data.isSelected,
                            onChanged: (val) {
                              setState(() {
                                updateNode(
                                  _treeViewController,
                                  val ?? false,
                                  node,
                                );
                                serviceCategoriesBloc.add(
                                  UpdateAvailableServices(
                                    node.data.id,
                                    val ?? false,
                                  ),
                                );
                              });
                            },
                            title: Text(node.label),
                          );
                        },
                        theme: const TreeViewTheme(
                          expanderTheme: ExpanderThemeData(
                            type: ExpanderType.chevron,
                            modifier: ExpanderModifier.none,
                            position: ExpanderPosition.start,
                            animated: true,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            serviceCategoriesBloc.add(
                                const SearchServiceCategories(searchText: ''));
                            _searchController.clear();
                            TripServiceBloc tripServiceBloc =
                                BlocProvider.of(context);
                            tripServiceBloc.add(AddServices(
                                tripServices: serviceCategoriesBloc
                                    .getSelectedServices()));
                          },
                          child: const Text('Apply')),
                    ),
                  ],
                );
              },
            );
          case FetchServiceCategoriesState.failure:
            return noDataFoundWidget();
        }
      },
    );
  }

  void updateNode(
    TreeViewController treeViewController,
    bool isChecked,
    Node node,
  ) {
    NodeDetails nodeDetails = node.data;
    node.data.isSelected = isChecked;
    treeViewController.updateNode(node.key, node);
    if (nodeDetails.type == NodeType.category) {
      for (Node value in node.children) {
        updateNode(treeViewController, isChecked, value);
      }
    }
  }

  List<Node> _getNodeList(List<ServiceCategory> serviceCategories) {
    int nodeKey = -1;
    return serviceCategories.map((e) {
      NodeDetails nodeDetails = NodeDetails(
        id: e.serviceCategoryId,
        type: NodeType.category,
        isSelected: false,
      );
      nodeKey++;
      return Node(
        data: nodeDetails,
        key: nodeKey.toString(),
        label: e.name,
        children: () {
          List<Node> allNodes = [];
          List<Node> services = [];
          if (e.service != null) {
            services = e.service!.map((e) {
              nodeKey++;
              NodeDetails nodeDetails = NodeDetails(
                id: e.serviceId,
                type: NodeType.service,
                isSelected: isServiceExists(
                  _tripServiceMain,
                  e.serviceId,
                ),
              );
              return Node(
                key: nodeKey.toString(),
                label: e.name,
                data: nodeDetails,
              );
            }).toList();
          }
          List<Node> categories = _getNodeList(e.childServiceCategory ?? []);
          allNodes.addAll(categories);
          allNodes.addAll(services);
          return allNodes;
        }(),
      );
    }).toList();
  }

  bool isServiceExists(TripServiceMain tripServiceMain, int serviceID) {
    ServiceCategoriesBloc serviceCategoriesBloc = BlocProvider.of(context);
    return serviceCategoriesBloc.selectedServiceIDs.contains(serviceID);
  }

  void modifySelectionInTree(
      bool val, List<tree.TreeNodeData> treeDataList, tree.TreeNodeData node) {
    for (var treeData in treeDataList) {
      NodeDetails details = treeData.extra;
      switch (details.type) {
        case NodeType.category:
          if (details.id == node.extra.id) {
            treeData.checked = val;
            if (treeData.children.isNotEmpty) {
              modifySelectionInTree(val, treeData.children, treeData);
            }
          }
          break;
        case NodeType.service:
          treeData.checked = val;
          break;
      }
    }
  }

  List<tree.TreeNodeData> getTreeData(List<ServiceCategory> serviceCategories) {
    return serviceCategories.map((ServiceCategory e) {
      //NodeDetails details = NodeDetails(NodeType.category, e.serviceCategoryId);
      return tree.TreeNodeData(
          //extra: details,
          title: e.name,
          expaned: false,
          checked: false,
          children: () {
            List<tree.TreeNodeData> allNodes = [];
            List<tree.TreeNodeData> services = [];
            if (e.service != null) {
              services = e.service!.map((e) {
                //NodeDetails details = NodeDetails(NodeType.service, e.serviceId);
                return tree.TreeNodeData(
                  //extra: details,
                  children: [],
                  checked: false,
                  expaned: false,
                  title: e.name,
                );
              }).toList();
            }
            List<tree.TreeNodeData> categories =
                getTreeData(e.childServiceCategory ?? []);
            allNodes.addAll(categories);
            allNodes.addAll(services);
            return allNodes;
          }());
    }).toList();
  }

  Widget _buildServicesWidget(TripServiceMain tripService) {
    if (tripService.services == null || tripService.schedule == null) {
      return noDataFoundWidget();
    }
    _tripServiceMain = tripService;
    bool _showServiceList = true;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: spacing280),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightBlueGrey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 100,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _searchController,
                                    onChanged: (value) {
                                      if (!_showServiceList) {
                                        ServiceCategoriesBloc
                                            serviceCategoryBloc =
                                            BlocProvider.of(context);
                                        serviceCategoryBloc.add(
                                          SearchServiceCategories(
                                            searchText: value,
                                          ),
                                        );
                                      } else {
                                        tripServiceBloc.add(
                                          SearchServices(value),
                                        );
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Search Services',
                                      prefixIcon: const Icon(Icons.search),
                                      suffixIcon: Visibility(
                                        visible:
                                            _searchController.text.isNotEmpty,
                                        child: IconButton(
                                          icon: const Icon(Icons.close_rounded),
                                          onPressed: () {
                                            setState(() {
                                              tripServiceBloc.add(
                                                const SearchServices(''),
                                              );
                                              _searchController.text = '';
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: _showServiceList
                                      ? const Icon(Icons.add_rounded)
                                      : const Icon(Icons.close_rounded),
                                  onPressed: () {
                                    if (!tripServiceBloc.editMode) {
                                      showEnableEditSnackBar();
                                      return;
                                    }
                                    setState(() {
                                      _showServiceList = !_showServiceList;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: _showServiceList
                              ? _buildServiceList(tripService)
                              : _buildServiceSelector(tripService),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SfDataGrid(
              verticalScrollController: gridScrollController,
              isScrollbarAlwaysShown: true,
              shrinkWrapRows: true,
              //verticalScrollPhysics: const NeverScrollableScrollPhysics(),
              onCellTap: (DataGridCellTapDetails details) => _onCellTapHandler(
                details,
                tripService,
              ),
              gridLinesVisibility: GridLinesVisibility.both,
              navigationMode: GridNavigationMode.cell,
              headerRowHeight: spacing100,
              onQueryRowHeight: (details) {
                return details.rowIndex == 0 ? spacing100 : spacing44;
              },
              columns: tripService.schedule!.map((schedule) {
                return _buildColumnHeader(
                  schedule.tripScheduleId ?? 0,
                  schedule.airportId ?? 0,
                  schedule.countryId ?? 0,
                  heading: schedule.name ?? '',
                  takeOff: schedule.eTD ?? '',
                  landing: schedule.eTA ?? '',
                  timezone: schedule.timezone ?? '',
                  isOverFlight: schedule.isOverFlight ?? false,
                );
              }).toList(),
              source: ServiceDataSource(
                context: context,
                tripServiceMain: tripService,
              ),
            ),
          ),
        )
      ],
    );
  }

  void _onCellTapHandler(
    DataGridCellTapDetails details,
    TripServiceMain tripService,
  ) async {
    RowColumnIndex index = details.rowColumnIndex;
    if (index.rowIndex == 0) return;
    if (!tripServiceBloc.editMode) {
      showEnableEditSnackBar();
      return;
    }
    TripService service = tripService.services![index.rowIndex - 1];
    String serviceName = service.service ?? '';
    TripServiceSchedule tripSchedule = tripService.schedule![index.columnIndex];
    if (TripServiceBloc.canAddServiceToSchedule(
      tripSchedule: tripSchedule,
      serviceName: service.service ?? '',
    )) {
      addServiceToSchedule(
        tripSchedule.tripScheduleId,
        service.serviceId,
        tripSchedule.isOverFlight,
        tripSchedule.tripOverflyId,
      );
      TripServiceBloc tripServiceBloc = BlocProvider.of(context);
      tripServiceBloc.add(
        AddToPayload(
          addToPayloadMode: AddToPayloadMode.add,
          tripSchedule: tripSchedule,
          tripService: service,
          tripOverflyId: tripSchedule.tripOverflyId,
        ),
      );
      print("====Added and set state");
      setState(() {});
      return;
    }
    AppHelper().showSnackBar(
      context,
      message: serviceName + ' cannot be added to ' + (tripSchedule.name ?? ''),
    );
    setState(() {});
  }

  void addServiceToSchedule(int? tripScheduleID, int? serviceID,
      bool? isOverflight, int? tripOverflyID) {
    TripServiceBloc tripServiceBloc = BlocProvider.of(context);
    tripServiceBloc.add(
      AddNewService(
        scheduleID: tripScheduleID ?? 0,
        serviceID: serviceID ?? 0,
        isOverFlight: isOverflight ?? false,
        tripOverflyID: tripOverflyID ?? 0,
      ),
    );
  }

  void showEnableEditSnackBar() {
    AppHelper().showSnackBar(context,
        message: 'Click the edit button to make changes');
  }

  GridColumn _buildColumnHeader(
    int tripScheduleID,
    int airportID,
    int countryID, {
    bool isOverFlight = false,
    String heading = '',
    String? timezone,
    String landing = '',
    String takeOff = '',
  }) {
    return GridColumn(
      width: 200,
      columnName: tripScheduleID.toString(),
      columnWidthMode: ColumnWidthMode.fitByCellValue,
      label: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Text(
                      heading,
                      style: const TextStyle(
                        color: AppColors.charcoalGrey,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: InkWell(
                      onTap: () {
                        if (isOverFlight) {
                          if (countryID != 0) {
                            _showOverFlightDialog(countryID: countryID);
                          }
                        } else {
                          showLocationDialog(
                            airportID: airportID,
                            countryID: countryID,
                          );
                        }
                      },
                      child: const Icon(
                        Icons.info_rounded,
                        size: 12,
                        color: AppColors.iconGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isOverFlight)
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CustomPaint(
                      painter: DrawDottedHorizontalLine(),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.flight_rounded,
                        color: AppColors.greyishBrown,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (!isOverFlight)
            Expanded(
              flex: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (landing != '')
                    Expanded(
                      flex: 1,
                      child: Visibility(
                        visible: landing.isNotEmpty,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Icons.flight_land_rounded,
                                  size: 12,
                                  color: AppColors.iconGrey,
                                ),
                              ),
                              ValueListenableBuilder<bool>(
                                valueListenable: isUTC,
                                builder: (context, bool value, child) {
                                  return Text(
                                    convertDateTimeYYYYMMDDHHMMSSStringToHumanReadableFormat(
                                      landing,
                                      isUTC: value,
                                      timezone: timezone,
                                    ),
                                    style: const TextStyle(
                                      color: AppColors.charcoalGrey,
                                      fontSize: 12,
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (takeOff != '')
                    Expanded(
                      flex: 1,
                      child: Visibility(
                        visible: takeOff.isNotEmpty,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.flight_takeoff_rounded,
                                size: 12,
                                color: AppColors.iconGrey,
                              ),
                            ),
                            ValueListenableBuilder<bool>(
                              valueListenable: isUTC,
                              builder: (context, bool value, child) {
                                return Text(
                                  convertDateTimeYYYYMMDDHHMMSSStringToHumanReadableFormat(
                                    takeOff,
                                    isUTC: value,
                                    timezone: timezone,
                                  ),
                                  style: const TextStyle(
                                    color: AppColors.charcoalGrey,
                                    fontSize: 12,
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _showOverFlightDialog({required int countryID}) {
    showGeneralDialog(
      context: context,
      pageBuilder: (_, __, ___) {
        return Padding(
          padding: const EdgeInsets.all(50),
          child: WAirportFlightRequirementsPopup(
            type: TripServiceModalType.OVERFLY,
            countryID: countryID,
          ),
        );
      },
    );
  }

  void showLocationDialog({required int airportID, required countryID}) {
    showGeneralDialog(
        context: context,
        pageBuilder: (_, __, ___) {
          return Padding(
            padding: const EdgeInsets.all(50),
            child: WAirportFlightRequirementsPopup(
              type: TripServiceModalType.LOCATION,
              airportID: airportID,
              countryID: countryID,
            ),
          );
        });
  }
}
