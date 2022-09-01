import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/company_profile/bloc/notes/customer_notes_bloc.dart';
import 'package:gtm/_shared/widgets/buttons/cancel_edit_save_buttons.dart';

class WCompanyProfileOperationalNotes extends StatefulWidget {
  const WCompanyProfileOperationalNotes(
      {Key? key, required this.companyProfile})
      : super(key: key);
  final CompanyProfile companyProfile;

  @override
  State<WCompanyProfileOperationalNotes> createState() =>
      _WCompanyProfileOperationalNotesState();
}

class _WCompanyProfileOperationalNotesState
    extends State<WCompanyProfileOperationalNotes> {
  bool editBool = false;
  var updateObj;

  List<Notes>? _notesList;
  List<ServiceList> _serviceList = [];
  ServiceList? selectedService;

  @override
  void initState() {
    super.initState();
    context
        .read<CustomerNotesBloc>()
        .add(FetchNotesEvent(widget.companyProfile.organizationId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerNotesBloc, CustomerNotesState>(
      listener: (context, state) {},
      child: BlocBuilder<CustomerNotesBloc, CustomerNotesState>(
          builder: (context, state) {
        if (state.status == NoteStatus.loading ||
            state.status == NoteStatus.initial) {
          return loadingWidget();
        }
        if (state.status == NoteStatus.success) {
          _notesList = state.notes;
          _serviceList = state.serviceList;
        }

        log(_notesList.toString());
        return Stack(
          children: [
            SingleChildScrollView(
              child: AbsorbPointer(
                absorbing: !editBool,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          _getServiceDropDownMenuField(),
                          Container(
                            height: 60,
                            width: 70,
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                setState(() {});
                              },
                              child: Container(
                                height: 40,
                                width: 70,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    color: AppColors.greyColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Text('Add'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: _notesList?.length,
                        itemBuilder: (BuildContext context, int index) {
                          List tableColumns = [
                            _notesList?[index].service.service,
                            'Actions'
                          ];
                          List tableColumnsWidth = [0, 200];
                          return Column(
                            children: [
                              CmsTableHeader(
                                columns: tableColumns,
                                columnsWidth: tableColumnsWidth,
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _notesList?[index]
                                      .customerHasOperationalNotes
                                      ?.length,
                                  itemBuilder: (BuildContext cont, int ind) {
                                    List<List<Widget>> rows = [];
                                    _notesList?[index]
                                        .customerHasOperationalNotes
                                        ?.forEach((val) {
                                      rows.add([
                                        HtmlWidget(val.note),
                                        appText(''),
                                      ]);
                                    });
                                    Widget actions = GestureDetector(
                                      onTap: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.remove_circle,
                                            color: Colors.red,
                                          ),
                                          appText(
                                            'Remove',
                                            color: AppColors.powderBlue,
                                          )
                                        ],
                                      ),
                                    );
                                    Widget addAction = GestureDetector(
                                      onTap: () {
                                        rows.clear();
                                        rows.add([
                                          TextFormField(
                                            controller:
                                                TextEditingController(text: ''),
                                            onChanged: (value) {},
                                          ),
                                        ]);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.add,
                                          ),
                                          appText(
                                            'Add',
                                          )
                                        ],
                                      ),
                                    );

                                    Widget expWidget = Container();
                                    return CmsTableRow(
                                      isExpandable: false,
                                      addActions: ind == 0 ? addAction : null,
                                      editBool: editBool,
                                      actions: actions,
                                      expandedWidget: expWidget,
                                      columns: tableColumns,
                                      columnsWidth: tableColumnsWidth,
                                      row: rows[ind],
                                      itemIndex: ind,
                                    );
                                  }),
                              CmsTableFooter(
                                columnsWidth: tableColumnsWidth,
                              ),
                              const SizedBox(height: 8),
                            ],
                          );
                        }),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: CancelEditSaveButtons(
                editBool: editBool,
                updateObj: updateObj,
                onCancel: () {
                  setState(() => editBool = false);
                },
                onSave: () {
                  setState(() => editBool = !editBool);
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _getServiceDropDownMenuField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(spacing10),
        child: DropdownButtonFormField<ServiceList>(
            value: selectedService,
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(spacing4),
                hintText: 'Select Services'),
            items: _serviceList
                .map((e) => DropdownMenuItem<ServiceList>(
                    value: e,
                    child: Text(
                      e.service,
                    )))
                .toList(),
            onChanged: (onChanged) {
              if (onChanged != null) {
                selectedService = onChanged;
              }
            }),
      ),
    );
  }
}
