import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormTextFieldWidget extends StatelessWidget {
  final String fieldText;
  final String? hintText;
  final Widget? prefixIcon;
  final TextCapitalization? textCapitalization;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final Function? onChanged;
  final Function? validator;
  final bool? isEnabled;
  final String? errorText;
  final String? value;
  final int? maxLength;

  const CustomFormTextFieldWidget({
    Key? key,
    required this.fieldText,
    this.hintText,
    this.prefixIcon,
    this.textCapitalization,
    this.textInputType,
    this.inputFormatters,
    this.onChanged,
    this.validator,
    this.isEnabled,
    this.errorText,
    this.value,
    this.maxLength,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      enabled: isEnabled ?? true,
      textCapitalization: textCapitalization ?? TextCapitalization.words,
      keyboardType: textInputType ?? TextInputType.name,
      maxLength: maxLength,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: fieldText,
        hintText: hintText,
        counterText: '',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        errorText: errorText,
      ),
      inputFormatters: inputFormatters,
      onChanged: (val) => (onChanged != null ? onChanged!(val) : null),
      validator: (val) => (validator != null ? validator!(val) : null),
    );
  }
}
