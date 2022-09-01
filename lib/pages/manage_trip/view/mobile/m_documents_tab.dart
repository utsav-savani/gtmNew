import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/pages/manage_trip/bloc/document/documents_event.dart';
import 'package:gtm/pages/manage_trip/bloc/document/documents_pdf_bloc.dart';
import 'package:gtm/pages/manage_trip/bloc/document/documents_pdf_state.dart';
import 'package:gtm/pages/manage_trip/view/mobile/_partials/m_documents_filter_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class MDocumentsTab extends StatefulWidget {
  final String guid;
  const MDocumentsTab({Key? key, required this.guid}) : super(key: key);

  @override
  State<MDocumentsTab> createState() => _MDocumentsTabState();
}

class _MDocumentsTabState extends State<MDocumentsTab> {
  String? _pdfURL;
  @override
  void didChangeDependencies() {
    TripManagerDocumentPayload payload = TripManagerDocumentPayload(
      excludeCancelled: true,
      fuelRelease: false,
      guid: widget.guid,
      isLocal: true,
      isNOTAMS: false,
      isUTC: true,
      isWeather: false,
    );
    _fetchPDF(payload);
    super.didChangeDependencies();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  _fetchPDF(TripManagerDocumentPayload payload) {
    DocumentsPDFBloc documentsPDFBloc =
        BlocProvider.of<DocumentsPDFBloc>(context);
    documentsPDFBloc.add(FetchDocumentURL(payload: payload));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 172,
          child: BlocBuilder<DocumentsPDFBloc, DocumentPDFURLState>(
            builder: (BuildContext context, state) {
              if (state.status == FetchDocumentPDFURLState.loading) {
                return loadingWidget();
              }
              if (state.status == FetchDocumentPDFURLState.success) {
                if (state.pdfURL == null || state.pdfURL!.isEmpty) {
                  return noDataFoundWidget();
                }
                _pdfURL = state.pdfURL;
                return SfPdfViewer.network(state.pdfURL ?? '');
              }
              return noDataFoundWidget();
            },
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _pdfURL != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: FloatingActionButton(
                      elevation: 0,
                      child: const Icon(Icons.download),
                      onPressed: () {
                        Share.shareFiles([_pdfURL!]);
                      },
                    ),
                  ),
                )
              : Container(),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              elevation: 0,
              child: const Icon(Icons.filter_alt_outlined),
              onPressed: () => _documentsFilterTriggered(),
            ),
          ),
        ],
      ),
    );
  }

  void _documentsFilterTriggered() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return MDocumentsFilterWidget(guid: widget.guid);
      },
    );
  }
}
