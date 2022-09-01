import 'package:formz/formz.dart';

/// return Empty error
enum FilterTypeValidationError {
  /// an empty return
  empty
}

/// Email Address that has formz validation
class FilterType extends FormzInput<String, FilterTypeValidationError> {
  // return if not touched
  const FilterType.pure() : super.pure('');

  /// return if touched dirty
  const FilterType.dirty([String value = '']) : super.dirty(value);

  @override
  FilterTypeValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : FilterTypeValidationError.empty;
  }
}
