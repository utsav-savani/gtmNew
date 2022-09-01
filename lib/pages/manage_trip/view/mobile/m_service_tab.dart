import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:gtm/_shared/helpers/app_helper.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/custom_widgets.dart';
import 'package:gtm/pages/manage_trip/bloc/services/service_categories/service_categories_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/service_categories/service_categories_state.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/save_service_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_event.dart';
import 'package:gtm/pages/manage_trip/bloc/services/trip_service/trip_service_state.dart';
import 'package:gtm/pages/manage_trip/view/web/sevices/_partials/service_extensions.dart';
import 'package:gtm/pages/manage_trip/view/web/sevices/trip_service_popup.dart';
import 'package:gtm/pages/widgets/trip_accordion.dart';
import 'package:service_category_repository/service_category_repository.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class MServiceTab extends StatefulWidget {
  final TripDetail tripDetail;

  const MServiceTab({Key? key, required this.tripDetail}) : super(key: key);

  @override
  State<MServiceTab> createState() => _MServiceTabState();
}

class _MServiceTabState extends State<MServiceTab> {
  late TripDetail _tripDetail;
  late TripServiceMain _tripServiceMain;

  @override
  void initState() {
    _tripDetail = widget.tripDetail;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    fetchTripService();
    super.didChangeDependencies();
  }

  void fetchTripService() {
    TripServiceBloc tripServiceBloc = BlocProvider.of(context);
    tripServiceBloc.add(FetchTripService(guid: widget.tripDetail.guid ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TripServiceBloc, TripServiceState>(
        builder: (BuildContext context, TripServiceState state) {
          switch (state.status) {
            case FetchTripServiceStatus.initial:
            case FetchTripServiceStatus.idle:
            case FetchTripServiceStatus.loading:
              return _buildCircularProgress();
            case FetchTripServiceStatus.success:
              return _buildServices(state.tripServiceMain);
            case FetchTripServiceStatus.failure:
              return _buildNoData();
          }
        },
      ),
    );
  }

  Widget _buildServices(TripServiceMain tripService) {
    _tripServiceMain = tripService;
    List<TripServiceSchedule> schedules = tripService.schedule ?? [];
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 130,
        child: Column(
          children: [
            SizedBox(
              height: 62,
              child: _buildTripInfoWidget(),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (c, i) {
                  TripServiceSchedule tripSchedule = schedules[i];
                  List<TripService> scheduleServices =
                      tripSchedule.services ?? [];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TripAccordion(
                      listTileColor: AppColors.deepLavender,
                      titleWidget: _buildTitleWidget(
                        tripSchedule: tripSchedule,
                        tripServiceMain: tripService,
                      ),
                      content: ListView.builder(
                        itemCount: scheduleServices.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          TripService scheduleService = scheduleServices[index];
                          return _buildCategoryWidget(
                            tripService: scheduleService,
                            tripSchedule: tripSchedule,
                          );
                        },
                      ),
                    ),
                  );
                },
                itemCount: schedules.length,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    try {
                      List<TripServiceSchedulePayload> payload =
                          tripService.schedule!.map((e) {
                        return TripServiceSchedulePayload(
                            tripScheduleId: e.tripScheduleId ?? 0,
                            tripServices: e.services!.map((e) {
                              Map<String, dynamic> service =
                                  <String, dynamic>{};
                              service[(e.tripServiceId ?? 0).toString()] =
                                  e.serviceStatus;
                              return service;
                            }).toList());
                      }).toList();
                      SaveServiceBloc saveServiceBloc =
                          BlocProvider.of(context);
                      saveServiceBloc.add(SaveService(
                          guid: widget.tripDetail.guid ?? '',
                          tripServiceSchedulePayload: payload,
                          flightCategoryId:
                              tripService.schedule![0].flightCategoryId ?? 0));
                    } catch (e) {
                      AppHelper().showSnackBar(context,
                          message: 'Failed to save service data');
                    }
                  },
                  child: BlocListener<SaveServiceBloc, SaveServiceState>(
                    listener: (context, state) {
                      if (state == SaveServiceState.success) {
                        AppHelper().showSnackBar(context,
                            message: 'Saved Successfully');
                      } else if (state == SaveServiceState.failure) {
                        AppHelper().showSnackBar(context,
                            message: 'Failed to save service data');
                      }
                    },
                    child: BlocBuilder<SaveServiceBloc, SaveServiceState>(
                      builder: (context, state) {
                        switch (state) {
                          case SaveServiceState.initial:
                          case SaveServiceState.success:
                          case SaveServiceState.failure:
                            return const Text('Save');
                          case SaveServiceState.loading:
                            return CustomWidgets().buildCircularProgressSmall(
                                color: Colors.white);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoData() {
    return Center(
      child: Text('noDataFound'.translate()),
    );
  }

  Widget _buildCircularProgress() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildTitleWidget({
    required TripServiceSchedule tripSchedule,
    required TripServiceMain tripServiceMain,
  }) {
    String? departureTime = tripSchedule.eTA;
    String? arrivalTime = tripSchedule.eTD;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          label(tripSchedule.name ?? '', color: AppColors.whiteColor),
          width(20),
          Column(
            children: [
              if (departureTime != null)
                Row(
                  children: [
                    svgToIcon(appImagesName: AppImages.departureIcon),
                    width(4),
                    label(
                      convertDateTimeYYYYMMDDHHMMSSStringToHumanReadableFormat(
                        departureTime,
                      ),
                      color: AppColors.whiteColor,
                    ),
                  ],
                ),
              if (arrivalTime != null) height(8),
              if (arrivalTime != null)
                Row(
                  children: [
                    svgToIcon(appImagesName: AppImages.arrivalIcon),
                    width(4),
                    label(
                      convertDateTimeYYYYMMDDHHMMSSStringToHumanReadableFormat(
                        arrivalTime,
                      ),
                      color: AppColors.whiteColor,
                    ),
                  ],
                ),
            ],
          ),
          width(12),
          const Spacer(),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return FractionallySizedBox(
                      heightFactor: 0.9,
                      child:
                          _buildServiceSelector(tripSchedule, tripServiceMain),
                    );
                    // return _buildServiceSelector(tripSchedule, tripServiceMain);
                  });
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.defaultColor,
                border: Border.all(
                  color: AppColors.defaultColor,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: label("Add Service", color: AppColors.whiteColor),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTripInfoWidget() {
    return Card(
      child: MergeSemantics(
        child: ListTile(
          contentPadding: null,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              label("Trip Id"),
              height(4),
              Text(
                "${_tripDetail.tripNumber}".toUpperCase(),
                style: const TextStyle(
                  color: AppColors.charcoalGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 0.6,
                ),
              ),
              height(8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryWidget(
      {required TripServiceSchedule tripSchedule,
      required TripService tripService}) {
    ServiceStatus status;
    switch (tripService.serviceStatus) {
      case TripServiceBloc.newService:
        status = ServiceStatus.newService;
        break;
      case TripServiceBloc.inProgress:
        status = ServiceStatus.inProgress;
        break;
      case TripServiceBloc.confirmed:
        status = ServiceStatus.confirmed;
        break;
      case TripServiceBloc.cancelled:
        status = ServiceStatus.cancelled;
        break;
      default:
        status = ServiceStatus.newService;
        break;
    }
    bool isMandatoryFlagVisible = false;
    bool canDeleteService = false;
    Color foregroundColor;
    Color backgroundColor;
    String statusText;
    String serviceManagedBy = 'UAS';
    //serviceManagedBy = serviceManagedBy.split('').join('\n');
    switch (status) {
      case ServiceStatus.newService:
        isMandatoryFlagVisible = true;
        canDeleteService = true;
        backgroundColor = AppColors.blueGrey;
        foregroundColor = AppColors.coolBlue;
        statusText = 'New';
        break;
      case ServiceStatus.inProgress:
        isMandatoryFlagVisible = true;
        canDeleteService = false;
        backgroundColor = AppColors.lightPeach;
        foregroundColor = AppColors.apricot;
        statusText = 'In Progress';
        break;
      case ServiceStatus.confirmed:
        isMandatoryFlagVisible = true;
        canDeleteService = false;
        backgroundColor = AppColors.silver;
        foregroundColor = AppColors.jadeGreen;
        statusText = 'Confirmed';
        break;
      case ServiceStatus.cancelled:
        isMandatoryFlagVisible = false;
        canDeleteService = false;
        backgroundColor = AppColors.peachyPink;
        foregroundColor = AppColors.redColor;
        statusText = 'Cancelled';
        break;
    }
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      label(
                        tripService.service ?? '',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.charcoalGrey,
                      ),
                      IconButton(
                          onPressed: () {
                            showGeneralDialog(
                                context: context,
                                pageBuilder: (context, _, __) {
                                  return TripServicePopup(
                                      type: (tripSchedule.isOverFlight ?? false)
                                          ? TripServiceModalType.OVERFLY
                                          : TripServiceModalType.LOCATION,
                                      typeId: tripService.tripServiceId ?? 0);
                                });
                          },
                          icon: const Icon(Icons.info)),
                    ],
                  ),
                  height(12),
                  label(serviceManagedBy,
                      fontSize: 14, color: AppColors.brownGrey),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  label(statusText, fontSize: 16, color: foregroundColor),
                  height(12),
                  if (status == ServiceStatus.newService)
                    InkWell(
                      onTap: () {
                        if (tripService.isRemovable ?? false) {
                          TripServiceBloc tripServiceBloc =
                              BlocProvider.of(context);
                          tripServiceBloc.add(
                            DeleteTripService(
                              tripServiceID: tripService.serviceId ?? 0,
                              tripServiceScheduleID:
                                  tripSchedule.tripScheduleId ?? 0,
                              isOverFlight: tripSchedule.isOverFlight ?? false,
                              tripOverflyID: tripSchedule.tripOverflyId!,
                            ),
                          );
                        } else {
                          AppHelper().showSnackBar(context,
                              message: (tripService.service ?? '') +
                                  ' cannot be removed');
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: svgToIcon(
                          appImagesName: AppImages.minusIcon,
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceSelector(
      TripServiceSchedule tripSchedule, TripServiceMain tripService) {
    late TreeViewController _treeViewController;
    return BlocBuilder<ServiceCategoriesBloc, ServiceCategoriesState>(
      builder: (context, state) {
        switch (state.status) {
          case FetchServiceCategoriesState.initial:
          case FetchServiceCategoriesState.loading:
            return _buildCircularProgress();
          case FetchServiceCategoriesState.success:
            _treeViewController = TreeViewController(
                children: getNodeList(tripSchedule, state.serviceCategories));
            return StatefulBuilder(
              builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return Scaffold(
                  body: SafeArea(
                    child: Column(
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
                                  String serviceName = node.label;
                                  if (TripServiceBloc.canAddServiceToSchedule(
                                      tripSchedule: tripSchedule,
                                      serviceName: serviceName)) {
                                    updateNode(_treeViewController,
                                        val ?? false, node);
                                    return;
                                  }
                                  AppHelper().showSnackBar(context,
                                      message: serviceName +
                                          ' cannot be added to ' +
                                          (tripSchedule.name ?? ''));
                                },
                                title: Text(node.label),
                              );
                            },

                            // Arrow Animation will not work
                            // Tree view is collapsing if its having nested children so commented
                            // for now in both web and mobile for web ref: w_service_page.dart

                            /*onExpansionChanged: (key, state) {
                              Node? node = _treeViewController.getNode(key);
                              if (node != null) {
                                node = node.copyWith(expanded: state);
                                setState(() {
                                  _treeViewController = _treeViewController.withUpdateNode(key, node!);
                                });
                              }
                            },*/
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
                                TripServiceBloc tripServiceBloc =
                                    BlocProvider.of(context);
                                tripServiceBloc.add(AddServicesToSchedule(
                                    tripServices: getSelectedNodeList(
                                        _treeViewController.children),
                                    scheduleID:
                                        tripSchedule.tripScheduleId ?? 0));
                                Navigator.of(context).pop();
                              },
                              child: const Text('Apply')),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          case FetchServiceCategoriesState.failure:
            return _buildNoData();
        }
      },
    );
  }

  void updateNode(
      TreeViewController treeViewController, bool isChecked, Node node) {
    NodeDetails nodeDetails = node.data;
    node.data.isSelected = isChecked;
    treeViewController.updateNode(node.key, node);
    if (nodeDetails.type == NodeType.category) {
      for (Node value in node.children) {
        updateNode(treeViewController, isChecked, value);
      }
    }
  }

  List<TripService> getSelectedNodeList(List<Node> nodes) {
    List<Node> flattenedList =
        nodes.expand<Node>((Node element) => element.children).toList();
    List<TripService?> temp = flattenedList.map((element) {
      if (element.data.type == NodeType.service && element.data.isSelected) {
        return TripService(
          serviceStatus: TripServiceBloc.newService,
          scheduleStatus: TripServiceBloc.original,
          serviceId: element.data.id,
          service: element.label,
          isRemovable: true,
        );
      }
      return null;
    }).toList();
    return temp.whereType<TripService>().toList();
  }

  List<Node> getNodeList(TripServiceSchedule tripServiceSchedule,
      List<ServiceCategory> serviceCategories) {
    int nodeKey = -1;
    return serviceCategories.map((e) {
      NodeDetails nodeDetails = NodeDetails(
          id: e.serviceCategoryId, type: NodeType.category, isSelected: false);
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
                    isSelected:
                        isServiceExists(tripServiceSchedule, e.serviceId));
                return Node(
                    key: nodeKey.toString(), label: e.name, data: nodeDetails);
              }).toList();
            }
            List<Node> categories =
                getNodeList(tripServiceSchedule, e.childServiceCategory ?? []);
            allNodes.addAll(categories);
            allNodes.addAll(services);
            return allNodes;
          }());
    }).toList();
  }

  bool isServiceExists(TripServiceSchedule tripServiceSchedule, int serviceID) {
    List<TripService> services = tripServiceSchedule.services ?? [];
    List<TripService> temp = services.where((element) {
      String temp;
      if (element.serviceId == null) {
        temp = '';
      } else {
        temp = element.serviceId.toString();
      }
      return temp == serviceID.toString();
    }).toList();
    return temp.isNotEmpty;
  }
}
