import 'package:formz/formz.dart';

/// return Empty error
enum TextValidationError {
  /// an empty return
  empty
}

/// Text Address that has formz validation
class TextValidator extends FormzInput<String, TextValidationError> {
  // return if not touched
  const TextValidator.pure() : super.pure('');

  /// return if touched dirty
  const TextValidator.dirty([String value = '']) : super.dirty(value);

  @override
  TextValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : TextValidationError.empty;
  }
}
