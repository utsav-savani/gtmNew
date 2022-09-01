import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
part 'customer_document_event.dart';
part 'customer_document_state.dart';

class CustomerDocumentBloc
    extends Bloc<CustomerDocumentEvent, CustomerDocumentState> {
  final CompanyProfileRepository _companyProfileRepository;
  CustomerDocumentBloc(
      {required CompanyProfileRepository companyProfileRepository})
      : _companyProfileRepository = companyProfileRepository,
        super(CustomerDocumentInitial(status: DocumentStatus.initial)) {
    on<GetDocumentsEvent>(_getCustomerDocuments);
    on<UpdateDocumentEvent>(_updateDocument);
    on<DownloadDocumentEvent>(_downloadDocument);
  }

  Future<void> _getCustomerDocuments(
      GetDocumentsEvent event, Emitter<CustomerDocumentState> emit) async {
    emit(CustomerDocumentState(
        status: DocumentStatus.initial, documents: state.documents));
    try {
      emit(CustomerDocumentState(
          status: DocumentStatus.loading, documents: state.documents));
      List<Documents> _response = await _companyProfileRepository
          .getCustomerDocuments(event.customerId);
      emit(
          state.copyWith(status: DocumentStatus.success, documents: _response));
    } catch (e) {
      emit(state.copyWith(
          status: DocumentStatus.failure, documents: state.documents));
    }
  }

  FutureOr<void> _updateDocument(
      UpdateDocumentEvent event, Emitter<CustomerDocumentState> emit) async {
    emit(CustomerDocumentState(
        status: DocumentStatus.initial, documents: state.documents));
    try {
      emit(CustomerDocumentState(
          status: DocumentStatus.loading, documents: state.documents));
      await _companyProfileRepository.updateCustomerDocument(
          event.fileToUpload, event.customerId, event.documentId);
      List<Documents> _response = await _companyProfileRepository
          .getCustomerDocuments(event.customerId);
      emit(
          state.copyWith(status: DocumentStatus.success, documents: _response));
    } catch (e) {
      emit(state.copyWith(
          status: DocumentStatus.failure, documents: state.documents));
    }
  }

  FutureOr<void> _downloadDocument(
      DownloadDocumentEvent event, Emitter<CustomerDocumentState> emit) async {
    try {
      final res =
          await _companyProfileRepository.downloadDocuments(event.docId);
      if (res != null) {
        await launchUrl(Uri.parse(res));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
