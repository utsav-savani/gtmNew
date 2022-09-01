import 'package:trip_manager_repository/trip_manager_repository.dart';

enum DownloadReportStatus { initial, loading, success, failure }

class DownloadReportState extends Equatable {
  final DownloadReportStatus status;
  final String reportURL;

  const DownloadReportState({
    this.status = DownloadReportStatus.initial,
    this.reportURL = '',
  });

  DownloadReportState copyWith({
    DownloadReportStatus? status,
    String? reportURL,
  }) {
    return DownloadReportState(
      status: status ?? this.status,
      reportURL: reportURL??'',
    );
  }

  @override
  List<Object?> get props => [status, reportURL];
}