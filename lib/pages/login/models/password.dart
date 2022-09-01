import 'package:formz/formz.dart';

/// return Empty error
enum PasswordValidationError {
  /// an empty return
  empty
}

/// Email Address that has formz validation
class Password extends FormzInput<String, PasswordValidationError> {
  // return if not touched
  const Password.pure() : super.pure('');

  /// return if touched dirty
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : PasswordValidationError.empty;
  }
}
