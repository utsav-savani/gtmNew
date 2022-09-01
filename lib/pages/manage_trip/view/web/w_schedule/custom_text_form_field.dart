import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtm/_shared/shared.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final double? height;
  final double? width;
  final String? value;
  final Function onChanged;
  final String? hintText;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String? counterText;
  final bool? isEditableMode;
  final AlwaysDisabledFocusNode? focusNode;

  const CustomTextFormField({
    Key? key,
    required this.label,
    required this.onChanged,
    this.height,
    this.width,
    this.value,
    this.hintText,
    this.inputFormatters,
    this.maxLength,
    this.keyboardType,
    this.counterText,
    this.isEditableMode,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String _value = value ?? "";
    return SizedBox(
      height: height ?? spacing48,
      width: width ?? spacing152,
      child: TextFormField(
        enableInteractiveSelection: isEditableMode ?? true,
        focusNode: focusNode,
        maxLength: maxLength,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          counterText: counterText ?? '',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(spacing6),
            borderSide: const BorderSide(
              color: AppColors.powderBlue,
            ),
          ),
          labelText: label,
          hintText: hintText,
        ),
        inputFormatters: inputFormatters,
        onChanged: (val) => onChanged(val),
        controller: TextEditingController()
          ..text = _value
          ..selection = TextSelection.collapsed(offset: _value.length),
      ),
    );
  }
}
