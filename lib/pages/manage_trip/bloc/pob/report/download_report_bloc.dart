import 'package:gtm/pages/manage_trip/bloc/pob/pob_event.dart';
import 'package:gtm/pages/manage_trip/bloc/pob/report/download_report_state.dart';
import 'package:trip_manager_repository/trip_manager_repository.dart';

class POBDownloadReportBloc extends Bloc<POBEvent, DownloadReportState> {
  final TripManagerPOBRepository _tripManagerPOBRepository;

  POBDownloadReportBloc({required TripManagerPOBRepository tripManagerPOBRepository})
      : _tripManagerPOBRepository = tripManagerPOBRepository,
        super(const DownloadReportState()) {
    on<DownloadReport>(_downloadReport);
  }

  Future<void> _downloadReport(
    POBEvent event,
    Emitter<DownloadReportState> emit,
  ) async {
    DownloadReport downloadReport = event as DownloadReport;
    if (downloadReport.guid.isEmpty) {
      return;
    }
    emit(state.copyWith(status: DownloadReportStatus.loading, reportURL: ''));
    try {
      final reportURL =
          await _tripManagerPOBRepository.getPOBCanpassDownload(guid: downloadReport.guid, pob: downloadReport.pob, office: downloadReport.office);
      emit(state.copyWith(status: DownloadReportStatus.success, reportURL: reportURL));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: DownloadReportStatus.failure, reportURL: ''));
    }
  }
}
