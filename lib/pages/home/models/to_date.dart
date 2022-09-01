import 'package:formz/formz.dart';

/// return Empty error
enum ToDateValidationError {
  /// an empty return
  empty
}

/// Email Address that has formz validation
class ToDate extends FormzInput<String, ToDateValidationError> {
  // return if not touched
  const ToDate.pure() : super.pure('');

  /// return if touched dirty
  const ToDate.dirty([String value = '']) : super.dirty(value);

  @override
  ToDateValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : ToDateValidationError.empty;
  }
}
