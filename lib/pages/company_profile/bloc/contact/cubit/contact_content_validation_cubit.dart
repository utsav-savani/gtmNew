import 'package:bloc/bloc.dart';
import 'package:company_profile_repository/company_profile_repository.dart';
import 'package:equatable/equatable.dart';

part 'contact_content_validation_state.dart';

class ContactContentValidationCubit
    extends Cubit<ContactContentValidationState> {
  final CompanyProfileRepository _companyProfileRepository;
  ContactContentValidationCubit(
      {required CompanyProfileRepository companyProfileRepository})
      : _companyProfileRepository = companyProfileRepository,
        super(const ContactContentValidationInitial(
            ContactContentValidationStatus.initial));

  Future<void> validateContactContent(
      int contactcategoryType, String content) async {
    try {
      bool res = await _companyProfileRepository.addcustomerdetailsvalidate(
          contactcategoryType: contactcategoryType, content: content);
      if (res) {
        emit(const ContactContentValidationState(
            ContactContentValidationStatus.success));
      } else {
        emit(const ContactContentValidationState(
            ContactContentValidationStatus.failure));
      }
    } catch (e) {
      emit(const ContactContentValidationState(
          ContactContentValidationStatus.failure));
    }
  }
}
