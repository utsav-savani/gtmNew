import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/app_helper.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/custom_widgets.dart';
import 'package:gtm/pages/manage_trip/bloc/document/documents_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/document/documents_event.dart';
import 'package:gtm/pages/manage_trip/bloc/document/documents_pdf_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/document/documents_pdf_state.dart';
import 'package:gtm/pages/manage_trip/bloc/document/documents_state.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class WDocumentsPage extends StatefulWidget {
  final String guid;

  const WDocumentsPage({required this.guid, Key? key}) : super(key: key);

  @override
  State<WDocumentsPage> createState() => _WDocumentsPageState();
}

class _WDocumentsPageState extends State<WDocumentsPage> {
  // static const String guid = '289d07d8-bcd8-4d45-d167-03a7853eb203';

  // state
  List<TripDocumentSchedule> toList = [];
  List<SelectionHelper<TripDocumentService>> services = [];
  String service = '';
  String? from;
  String? to;
  bool excludeCancelled = false;
  bool isLocal = true;
  bool isUTC = true;
  bool isWeather = false;
  bool fuelRelease = false;
  bool isNOTAMs = false;
  String? pdfURL;

  @override
  void didChangeDependencies() {
    TripManagerDocumentPayload payload = TripManagerDocumentPayload(
      excludeCancelled: true,
      fuelRelease: false,
      guid: widget.guid,
      isLocal: true,
      isNOTAMS: false,
      isUTC: false,
      isWeather: false,
    );
    fetchPDF(payload);
    fetchDocumentFilter(widget.guid);
    super.didChangeDependencies();
  }

  fetchPDF(TripManagerDocumentPayload payload) {
    DocumentsPDFBloc documentsPDFBloc = BlocProvider.of<DocumentsPDFBloc>(context);
    documentsPDFBloc.add(FetchDocumentURL(payload: payload));
  }

  fetchDocumentFilter(String guid) {
    DocumentFilterBloc documentFilterBloc = BlocProvider.of<DocumentFilterBloc>(context);
    documentFilterBloc.add(FetchDocumentFilter(guid: guid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(spacing20),
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Brief',
                    style: TextStyle(fontSize: 22, color: AppColors.charcoalGrey),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.powderBlue,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(6))),
                      child: BlocListener<DocumentFilterBloc, DocumentFilterState>(
                        listener: (context, state) {},
                        child: BlocBuilder<DocumentFilterBloc, DocumentFilterState>(
                          builder: (context, state) {
                            switch (state.status) {
                              case FetchDocumentsFilter.initial:
                              case FetchDocumentsFilter.loading:
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              case FetchDocumentsFilter.success:
                                if (state.tripDocumentFilter == null) {
                                  return getNoDataWidget();
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ListView(
                                    children: [
                                      getSectors(state.tripDocumentFilter!),
                                      getPreferences(state.tripDocumentFilter!),
                                      getIncludedDocuments(state.tripDocumentFilter!),
                                      getServiceType(state.tripDocumentFilter!),
                                      getButtons(state.tripDocumentFilter!),
                                    ],
                                  ),
                                );
                              case FetchDocumentsFilter.failure:
                                return getErrorWidget();
                              default:
                                return Container();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Brief Preview',
                          style: TextStyle(fontSize: 22, color: AppColors.charcoalGrey),
                        ),
                        IconButton(
                            onPressed: () async {
                              if (pdfURL == null) {
                                return;
                              }
                              try {
                                Uri _url = Uri.parse(pdfURL!);
                                await launchUrl(_url);
                              } catch (e) {
                                AppHelper().showSnackBar(context, message: 'Unable to open PDF');
                              }
                            },
                            icon: const Icon(Icons.open_in_new))
                      ],
                    ),
                    Expanded(
                      child: BlocBuilder<DocumentsPDFBloc, DocumentPDFURLState>(
                        builder: (BuildContext context, state) {
                          if (state.status == FetchDocumentPDFURLState.loading) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (state.status == FetchDocumentPDFURLState.success) {
                            if (state.pdfURL == null) {
                              return getNoDataWidget();
                            }
                            if (state.pdfURL!.isEmpty) {
                              return getNoDataWidget();
                            }
                            pdfURL = state.pdfURL;
                            return SfPdfViewer.network(
                              state.pdfURL ?? '',
                            );

                            // if (kIsWeb) {
                            //   //ignore: undefined_prefixed_name
                            //   ui.platformViewRegistry.registerViewFactory('iframe',
                            //       (int viewId) {
                            //     var iframe = html.IFrameElement();
                            //     iframe.src = state.pdfURL;
                            //     return iframe;
                            //   });
                            //   return const Expanded(
                            //       child: HtmlElementView(viewType: 'iframe'));
                            // } else {
                            //   return getNoDataWidget();
                            // }
                          }
                          return getNoDataWidget();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getSectors(TripDocumentFilterModel tripDocumentFilter) {
/*    if (tripDocumentFilter.tripScedule.isNotEmpty) {
      from = tripDocumentFilter.tripScedule[0].tripScheduleId.toString();
      List<TripDocumentSchedule> schedule = tripDocumentFilter.tripScedule.where((element) => element.tripScheduleId.toString() == from).toList();
      toList = tripDocumentFilter.tripScedule.where((element) {
        return element.tripsequenceNumber > schedule.first.tripsequenceNumber;
      }).toList();
      if (toList.isNotEmpty) {
        to = toList.first.tripScheduleId.toString();
      }
    }*/
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Sectors',
                style: TextStyle(fontSize: 16, color: AppColors.charcoalGrey),
              ),
            ),
            getDropdown(
              label: 'From',
              items: tripDocumentFilter.tripScedule
                  .map((e) => DropdownMenuItem<String>(
                        child: Text(e.name),
                        value: e.tripScheduleId.toString(),
                      ))
                  .toList(),
              //value: from,
              onChanged: (value) {
                List<TripDocumentSchedule> schedule =
                    tripDocumentFilter.tripScedule.where((element) => element.tripScheduleId.toString() == value).toList();
                setState(() {
                  from = value;
                  if (schedule.isNotEmpty) {
                    toList = tripDocumentFilter.tripScedule.where((TripDocumentSchedule element) {
                      return element.tripsequenceNumber > schedule.first.tripsequenceNumber;
                    }).toList();
                    if (toList.isNotEmpty) {
                      to = toList.first.tripScheduleId.toString();
                    }
                  }
                });
              },
              value: from,
            ),
            getDropdown(
                label: 'To',
                items: toList
                    .map((e) => DropdownMenuItem<String>(
                          child: Text(e.name),
                          value: e.tripScheduleId.toString(),
                        ))
                    .toList(),
                value: to,
                onChanged: (val) {
                  setState(() {
                    to = val;
                  });
                }),
          ],
        );
      },
    );
  }

  getPreferences(TripDocumentFilterModel tripDocumentFilterModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Preferences',
                style: TextStyle(fontSize: 16, color: AppColors.charcoalGrey),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  'Times:',
                  style: TextStyle(fontSize: 12, color: AppColors.charcoalGrey),
                ),
              ),
              Row(
                children: [
                  getCheckBox(
                      name: 'Local',
                      value: isLocal,
                      onChanged: (val) {
                        setState(() {
                          isLocal = !isLocal;
                        });
                      }),
                  getCheckBox(
                      name: 'UTC',
                      value: isUTC,
                      onChanged: (val) {
                        setState(() {
                          isUTC = !isUTC;
                        });
                      }),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  getIncludedDocuments(TripDocumentFilterModel tripDocumentFilterModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Included Documents',
                style: TextStyle(fontSize: 16, color: AppColors.charcoalGrey),
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.start,
                children: [
                  getCheckBox(
                      name: 'Fuel Release',
                      value: fuelRelease,
                      onChanged: (val) {
                        setState(() {
                          fuelRelease = !fuelRelease;
                        });
                      }),
                  getCheckBox(
                      name: 'Weather',
                      value: isWeather,
                      onChanged: (val) {
                        setState(() {
                          isWeather = !isWeather;
                        });
                      }),
                  getCheckBox(
                      name: 'NOTAMs',
                      value: isNOTAMs,
                      onChanged: (val) {
                        setState(() {
                          isNOTAMs = !isNOTAMs;
                        });
                      }),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  getServiceType(TripDocumentFilterModel tripDocumentFilterModel) {
    if (tripDocumentFilterModel.services.isNotEmpty) {
      service = tripDocumentFilterModel.services.first.service;
    }
    services = tripDocumentFilterModel.services.map((e) => SelectionHelper(e, false)).toList();
    String label = 'Select Services';
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) outerState) {
          //print(label);
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Service Type',
                style: TextStyle(fontSize: 16, color: AppColors.charcoalGrey),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomWidgets().buildDropdown(
                    label: label,
                    items: services
                        .map((e) => DropdownMenuItem<String>(
                              child: StatefulBuilder(
                                builder: (context, setState) {
                                  return CheckboxListTile(
                                    title: Text(e.data.service),
                                    onChanged: (v) {
                                      setState(() {
                                        e.isSelected = !e.isSelected;
                                      });
                                      outerState(() {
                                        int selectedCount = services.where((element) => element.isSelected).toList().length;
                                        if (selectedCount == 0) {
                                          label = 'Select Services';
                                        } else if (selectedCount == 1) {
                                          label = selectedCount.toString() + ' Service Selected';
                                        } else {
                                          label = selectedCount.toString() + ' Services Selected';
                                        }
                                      });
                                    },
                                    value: e.isSelected,
                                  );
                                },
                              ),
                              value: e.data.service,
                            ))
                        .toList(),
                    onChanged: (val) {}),
              ),
              getCheckBox(
                  name: 'Exclude Cancelled Services',
                  value: excludeCancelled,
                  onChanged: (val) {
                    outerState(() {
                      excludeCancelled = !excludeCancelled;
                    });
                  }),
            ],
          );
        },
      ),
    );
  }

  getButtons(TripDocumentFilterModel tripDocumentFilter) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              List<Map<String, dynamic>> schedule = [];
              List<Map<String, dynamic>> selectedService = [];
              List<TripDocumentSchedule> scheduleFrom =
                  tripDocumentFilter.tripScedule.where((element) => element.tripScheduleId.toString() == from).toList();
              List<TripDocumentSchedule> scheduleTo =
                  tripDocumentFilter.tripScedule.where((element) => element.tripScheduleId.toString() == to).toList();

              if (scheduleFrom.isNotEmpty) {
                schedule.add({'tripScheduleId': scheduleFrom.first.tripScheduleId});
              }
              if (scheduleTo.isNotEmpty) {
                schedule.add({'tripScheduleId': scheduleTo.first.tripScheduleId});
              }

              selectedService = services.map((e) {
                return {'serviceId': e.data.serviceId};
              }).toList();

              TripManagerDocumentPayload payload = TripManagerDocumentPayload(
                stations: schedule,
                services: selectedService,
                excludeCancelled: excludeCancelled,
                fuelRelease: fuelRelease,
                guid: widget.guid,
                isLocal: isLocal,
                isNOTAMS: isNOTAMs,
                isUTC: isUTC,
                isWeather: isWeather,
              );
              fetchPDF(payload);
            },
            child: const Text('Update'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(130, 48),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO Implement save
            },
            child: const Text('Save'),
            style: ElevatedButton.styleFrom(
              primary: AppColors.powderBlue,
              onPrimary: AppColors.deepLilac,
              minimumSize: const Size(130, 48),
            ),
          ),
        ],
      ),
    );
  }

  getCheckBox({String name = '', bool value = false, ValueChanged<bool?>? onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
          ),
          Text(name),
        ],
      ),
    );
  }

  getDropdown({
    String label = '',
    required List<DropdownMenuItem<String>> items,
    required ValueChanged onChanged,
    String? value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: CustomWidgets().buildDropdown<String>(items: items, onChanged: onChanged, label: label, value: value,selectFirstValue: false),
    );

    // try {
    //   return Padding(
    //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    //     child: InputDecorator(
    //       decoration: InputDecoration(
    //           border: const OutlineInputBorder(), labelText: label),
    //       child: DropdownButtonHideUnderline(
    //         child: DropdownButton<String>(
    //           isDense: true,
    //           items: items,
    //           onChanged: onChanged,
    //           value: value,
    //         ),
    //       ),
    //     ),
    //   );
    // } catch (e) {
    //   //print(e);
    //   return Container();
    // }
  }

  Future<Uint8List?> getPDFFile(String pdfURL) async {
    try {
      return await http
          .get(Uri(
        path: pdfURL,
      ))
          .then((response) {
        Uint8List bodyBytes = response.bodyBytes;
        return bodyBytes;
      });
    } catch (e) {
      //print(e);
      return null;
    }
  }

  getNoDataWidget() {
    return Center(
      child: Text('noDataFound'.translate()),
    );
  }

  getErrorWidget() {
    return Center(
      child: Text('Failed to load'.translate()),
    );
  }
}
