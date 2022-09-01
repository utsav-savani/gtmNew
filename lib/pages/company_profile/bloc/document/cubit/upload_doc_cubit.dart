import 'package:bloc/bloc.dart';
import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:equatable/equatable.dart';

part 'upload_doc_state.dart';

class UploadDocCubit extends Cubit<UploadDocState> {
  final CompanyProfileRepository _companyProfileRepository;
  UploadDocCubit({required CompanyProfileRepository companyProfileRepository})
      : _companyProfileRepository = companyProfileRepository,
        super(UploadDocInitial(status: UploadDocumentStatus.initial));

  Future<void> loadBasicDetails() async {
    emit(UploadDocState(
        status: UploadDocumentStatus.initial,
        documentTypes: state.documentTypes));
    try {
      emit(UploadDocState(
          status: UploadDocumentStatus.loading,
          documentTypes: state.documentTypes));

      List<DocumentType> _response =
          await _companyProfileRepository.getCustomerDocumentType();
      if (_response.isNotEmpty) {
        emit(state.copyWith(
            status: UploadDocumentStatus.success, documentTypes: _response));
      } else {
        emit(state.copyWith(
            status: UploadDocumentStatus.failure,
            documentTypes: state.documentTypes));
      }
    } catch (e) {
      emit(state.copyWith(
          status: UploadDocumentStatus.failure,
          documentTypes: state.documentTypes));
    }
  }

  Future<void> uploadCustomerDocument(UploadDocument documentData) async {
    emit(UploadDocState(
        status: UploadDocumentStatus.initial,
        documentTypes: state.documentTypes));
    try {
      emit(UploadDocState(
          status: UploadDocumentStatus.loading,
          documentTypes: state.documentTypes));

      bool _response =
          await _companyProfileRepository.uplodaCustomerDocuments(documentData);
      if (_response) {
        emit(state.copyWith(
            status: UploadDocumentStatus.success,
            documentTypes: state.documentTypes));
      } else {
        emit(state.copyWith(
            status: UploadDocumentStatus.failure,
            documentTypes: state.documentTypes));
      }
    } catch (e) {
      emit(state.copyWith(
          status: UploadDocumentStatus.failure,
          documentTypes: state.documentTypes));
    }
  }
}
