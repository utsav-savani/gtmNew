import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/cms/browse_document_widget.dart';
import 'package:gtm/_shared/widgets/cms/document_widget.dart';
import 'package:gtm/pages/company_profile/bloc/document/customer_document_bloc.dart';
import 'package:gtm/_shared/widgets/buttons/cancel_edit_save_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class WCompanyProfileDocuments extends StatefulWidget {
  const WCompanyProfileDocuments({Key? key, required this.companyProfile})
      : super(key: key);
  final CompanyProfile companyProfile;

  @override
  State<WCompanyProfileDocuments> createState() =>
      _WCompanyProfileDocumentsState();
}

class _WCompanyProfileDocumentsState extends State<WCompanyProfileDocuments> {
  bool editBool = false;
  var updateObj;

  List<Documents>? _documentsList;

  @override
  void initState() {
    super.initState();
    context
        .read<CustomerDocumentBloc>()
        .add(GetDocumentsEvent(widget.companyProfile.organizationId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerDocumentBloc, CustomerDocumentState>(
      listener: (context, state) {},
      child: BlocBuilder<CustomerDocumentBloc, CustomerDocumentState>(
          builder: (context, state) {
        if (state.status == DocumentStatus.loading ||
            state.status == DocumentStatus.initial) {
          return loadingWidget();
        }
        if (state.status == DocumentStatus.success) {
          _documentsList = state.documents;
        }
        if (_documentsList == null || _documentsList!.isEmpty) {
          return noDataFoundWidget();
        }

        List<List<Widget>> rows = [];
        _documentsList?.forEach((val) {
          rows.add([
            appText(val.name, color: AppColors.charcoalGrey),
            appText(val.documentType.name, color: AppColors.charcoalGrey),
            appText(
                val.issueDate != null
                    ? convertDateYYYYMMDDStringToHumanReadableFormat(
                        val.issueDate!)
                    : '',
                color: AppColors.charcoalGrey),
            appText(
                val.expireDate != null
                    ? convertDateYYYYMMDDStringToHumanReadableFormat(
                        val.expireDate!)
                    : '',
                color: AppColors.charcoalGrey),
            appText(val.documentFiles.length.toString(),
                color: AppColors.charcoalGrey),
            appText('', color: AppColors.charcoalGrey),
          ]);
        });
        List tableColumns = [
          'Name',
          'Type',
          'Issue Date',
          'Expiry Date',
          'Attachments',
          'Action'
        ];
        List tableColumnsWidth = [0, 200, 200, 200, 100, 200];
        return Stack(children: [
          SingleChildScrollView(
            child: Column(
              children: [
                CmsTableHeader(
                  columns: tableColumns,
                  columnsWidth: tableColumnsWidth,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: rows.length,
                    itemBuilder: (BuildContext context, int index) {
                      Widget actions = GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                      Widget expWidget = Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: AppColors.blueGrey,
                              width: 2.0,
                            ),
                            right: BorderSide(
                              color: AppColors.blueGrey,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Wrap(
                              direction: Axis.horizontal,
                              children:
                                  // MARK list of documents
                                  List<Widget>.generate(
                                          _documentsList?[index]
                                                  .documentFiles
                                                  .length ??
                                              0, (ind) {
                                        DocumentFiles? thisItem =
                                            _documentsList?[index]
                                                .documentFiles[ind];
                                        return DocumentWidget(
                                          name: thisItem!.name,
                                          docId: thisItem.documentFilesId,
                                          storedName: thisItem.storedName,
                                          onDownload: () async {
                                            final res =
                                                await CompanyProfileRepository()
                                                    .downloadDocuments(
                                              thisItem.documentFilesId,
                                            );
                                            if (res != null) {
                                              launchUrl(Uri.parse(res));
                                            }
                                            // context
                                            //     .read<CustomerDocumentBloc>()
                                            //     .add(DownloadDocumentEvent(
                                            //         thisItem.documentFilesId));
                                          },
                                        );
                                      }) +
                                      // MARK add new file
                                      [
                                        const BrowseWidget(),
                                      ]),
                        ),
                      );
                      return CmsTableRow(
                        isExpandable: true,
                        editBool: editBool,
                        actions: actions,
                        expandedWidget: expWidget,
                        columns: tableColumns,
                        columnsWidth: tableColumnsWidth,
                        row: rows[index],
                        itemIndex: index,
                      );
                    }),
                CmsTableFooter(
                  columnsWidth: tableColumnsWidth,
                ),
                const SizedBox(height: 80),
              ],
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
        ]);
      }),
    );
  }
}
