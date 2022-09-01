import 'package:formz/formz.dart';

/// return Empty error
enum FromDateValidationError {
  /// an empty return
  empty
}

/// Email Address that has formz validation
class FromDate extends FormzInput<String, FromDateValidationError> {
  // return if not touched
  const FromDate.pure() : super.pure('');

  /// return if touched dirty
  const FromDate.dirty([String value = '']) : super.dirty(value);

  @override
  FromDateValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : FromDateValidationError.empty;
  }
}
