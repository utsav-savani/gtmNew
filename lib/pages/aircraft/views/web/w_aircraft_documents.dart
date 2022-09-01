import 'package:aircraft_repository/aircraft_repository.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/_common/table_formatter.dart';
import 'package:gtm/_shared/widgets/cms/browse_document_widget.dart';
import 'package:gtm/_shared/widgets/cms/document_widget.dart';
import 'package:gtm/pages/aircraft/bloc/aircraft/aircraft_bloc.dart';
import 'package:gtm/pages/aircraft/bloc/document/document_bloc.dart';

class WAircraftDocuments extends StatefulWidget {
  const WAircraftDocuments({Key? key, this.aircraft}) : super(key: key);
  final AircraftDetails? aircraft;
  @override
  State<WAircraftDocuments> createState() => _WAircraftDocumentsState();
}

class _WAircraftDocumentsState extends State<WAircraftDocuments> {
  List<Document>? _documentsList = [];
  List documentsTableColumns = [
    'Name',
    'Type',
    'Issue Date',
    'Expiry Date',
    'Attachments',
    'Action'
  ];
  List documentsTableColumnsWidth = [0, 200, 200, 200, 100, 200];
  ScrollController mainListController = ScrollController();

  bool editBool = false;

  @override
  void didChangeDependencies() {
    AircraftDocumentBloc documentBloc =
        BlocProvider.of<AircraftDocumentBloc>(context);
    if (widget.aircraft != null) {
      documentBloc.add(FetchDocumentListEvent(widget.aircraft!.aircraftId));
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AircraftDocumentBloc, DocumentState>(
      listener: (context, state) {},
      child: BlocBuilder<AircraftDocumentBloc, DocumentState>(
          builder: (context, state) {
        if (state.status == DocummentListState.loading) {
          return loadingWidget();
        }
        if (state.status == DocummentListState.success) {
          if (state.documents.isNotEmpty) {
            _documentsList = state.documents;
          }
        }
        _documentsList?.sort((a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        List<List<Widget>> documentsRows = [];
        for (var val in _documentsList!) {
          documentsRows.add([
            appText(
              val.name,
              color: AppColors.charcoalGrey,
            ),
            appText(
              val.documentType?.name ?? '',
              color: AppColors.charcoalGrey,
            ),
            appText(
              val.issueDate,
              color: AppColors.charcoalGrey,
            ),
            appText(
              val.expireDate,
              color: AppColors.charcoalGrey,
            ),
            appText(
              val.documentFiles.length.toString(),
              color: AppColors.charcoalGrey,
            ),
            appText(
              '',
              color: AppColors.charcoalGrey,
            ),
          ]);
        }
        return SingleChildScrollView(
          controller: mainListController,
          child: Column(
            children: [
              CmsTableHeader(
                columns: documentsTableColumns,
                columnsWidth: documentsTableColumnsWidth,
              ),
              documentsRows.isEmpty
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
                      itemCount: documentsRows.length,
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
                                    _documentsList?[index].documentFiles == null
                                        ? [const BrowseWidget()]
                                        : List<Widget>.generate(
                                                _documentsList?[index]
                                                        .documentFiles
                                                        .length ??
                                                    0, (ind) {
                                              var thisItem =
                                                  _documentsList?[index]
                                                      .documentFiles[ind];
                                              return DocumentWidget(
                                                name: thisItem?.name,
                                                onDownload: () async {
                                                  context
                                                      .read<AircraftBloc>()
                                                      .add(DownloadDocument(
                                                          thisItem!
                                                              .documentFilesId));
                                                },
                                              );
                                            }) +
                                            // MARK add new file
                                            [const BrowseWidget()]),
                          ),
                        );
                        return CmsTableRow(
                          isExpandable: true,
                          editBool: editBool,
                          actions: actions,
                          expandedWidget: expWidget,
                          columns: documentsTableColumns,
                          columnsWidth: documentsTableColumnsWidth,
                          row: documentsRows[index],
                          itemIndex: index,
                        );
                      }),
              CmsTableFooter(
                columnsWidth: documentsTableColumnsWidth,
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}
