import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/_common/table_formatter.dart';
import 'package:gtm/_shared/widgets/cms/browse_document_widget.dart';
import 'package:gtm/_shared/widgets/cms/document_widget.dart';
import 'package:people_repository/people_repository.dart';

class WDocumentsPage extends StatefulWidget {
  const WDocumentsPage({Key? key, this.people}) : super(key: key);
  final People? people;
  @override
  State<WDocumentsPage> createState() => _WDocumentsPageState();
}

class _WDocumentsPageState extends State<WDocumentsPage> {
  People? oldObject;
  late People newObject;
  People? updateObj;
  bool editBool = false;

  var _searchBoxController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<Passport>? _passportList = widget.people?.passport ?? [];
    List<List<Widget>> passportRows = [];
    for (var val in _passportList) {
      passportRows.add([
        appText(val.number, color: AppColors.charcoalGrey),
        appText(val.type, color: AppColors.charcoalGrey),
        appText(val.issueDate, color: AppColors.charcoalGrey),
        appText(val.expireDate, color: AppColors.charcoalGrey),
        appText(val.crewPassportDocumentFiles?.length.toString() ?? '0',
            color: AppColors.charcoalGrey),
        appText('', color: AppColors.charcoalGrey),
      ]);
    }
    List passportTableColumns = [
      'Name',
      'Type',
      'Issue Date',
      'Expiry Date',
      'Attachements',
      'Action'
    ];
    List passportTableColumnsWidth = [0, 200, 200, 200, 100, 200];
    List<Visa>? _visaList = widget.people?.visa ?? [];
    List<List<Widget>> visaRows = [];
    for (var val in _visaList) {
      visaRows.add([
        appText(val.number, color: AppColors.charcoalGrey),
        appText(val.issueDate, color: AppColors.charcoalGrey),
        appText(val.expireDate, color: AppColors.charcoalGrey),
        appText(val.crewVisaDocumentFiles?.length.toString() ?? '0',
            color: AppColors.charcoalGrey),
        appText('', color: AppColors.charcoalGrey),
      ]);
    }
    List visaTableColumns = [
      'Name',
      'Issue Date',
      'Expiry Date',
      'Attachements',
      'Action'
    ];
    List visaTableColumnsWidth = [0, 200, 200, 100, 200];

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // MARK passport files table
          Container(
            padding: const EdgeInsets.all(8.0),
            child: appText(
              'Passports',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.charcoalGrey,
            ),
          ),
          Column(
            children: [
              CmsTableHeader(
                columns: passportTableColumns,
                columnsWidth: passportTableColumnsWidth,
              ),
              passportRows.isEmpty
                  ? Container(
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
                      child: noData(),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: passportRows.length,
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
                                    _passportList[index]
                                                .crewPassportDocumentFiles ==
                                            null
                                        ? [
                                            const BrowseWidget(),
                                          ]
                                        : List<Widget>.generate(
                                                _passportList[index]
                                                        .crewPassportDocumentFiles
                                                        ?.length ??
                                                    0, (ind) {
                                              var thisItem = _passportList[
                                                          index]
                                                      .crewPassportDocumentFiles![
                                                  ind];
                                              return DocumentWidget(
                                                name: thisItem.name,
                                                onDownload: () {},
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
                          columns: passportTableColumns,
                          columnsWidth: passportTableColumnsWidth,
                          row: passportRows[index],
                          itemIndex: index,
                        );
                      }),
              CmsTableFooter(
                columnsWidth: passportTableColumnsWidth,
              ),
              const SizedBox(height: 20),
            ],
          ),
          // MARK Visa files table
          Container(
            padding: const EdgeInsets.all(8.0),
            child: appText(
              'Visas',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.charcoalGrey,
            ),
          ),
          Column(
            children: [
              CmsTableHeader(
                columns: visaTableColumns,
                columnsWidth: visaTableColumnsWidth,
              ),
              visaRows.isEmpty
                  ? Container(
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
                      child: noData(),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: visaRows.length,
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
                                    _visaList[index].crewVisaDocumentFiles ==
                                            null
                                        ? [
                                            const BrowseWidget(),
                                          ]
                                        : List<Widget>.generate(
                                                _visaList[index]
                                                        .crewVisaDocumentFiles
                                                        ?.length ??
                                                    0, (ind) {
                                              var thisItem = _visaList[index]
                                                  .crewVisaDocumentFiles![ind];
                                              return DocumentWidget(
                                                name: thisItem.name,
                                                onDownload: () {},
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
                          columns: visaTableColumns,
                          columnsWidth: visaTableColumnsWidth,
                          row: visaRows[index],
                          itemIndex: index,
                        );
                      }),
              CmsTableFooter(
                columnsWidth: visaTableColumnsWidth,
              ),
              const SizedBox(height: 80),
            ],
          ),
        ],
      ),
    );
  }
}
