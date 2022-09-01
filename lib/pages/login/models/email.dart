import 'package:formz/formz.dart';

/// return Empty error
enum EmailAddressValidationError {
  /// an empty return
  empty
}

/// Email Address that has formz validation
class Email extends FormzInput<String, EmailAddressValidationError> {
  // return if not touched
  const Email.pure() : super.pure('');

  /// return if touched dirty
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailAddressValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : EmailAddressValidationError.empty;
  }
}
