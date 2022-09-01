part of 'contact_content_validation_cubit.dart';

enum ContactContentValidationStatus { initial, loading, success, failure }

class ContactContentValidationState extends Equatable {
  final ContactContentValidationStatus status;
  const ContactContentValidationState(this.status);

  @override
  List<Object> get props => [status];
}

class ContactContentValidationInitial extends ContactContentValidationState {
  const ContactContentValidationInitial(ContactContentValidationStatus status)
      : super(status);
}
