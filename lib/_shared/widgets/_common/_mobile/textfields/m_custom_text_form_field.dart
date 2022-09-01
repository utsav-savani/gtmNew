import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtm/_shared/shared.dart';

class MCustomTextFormField extends StatelessWidget {
  final double? width;
  final String? value;
  final Function onChanged;
  final String? hintText;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String? counterText;
  final FormFieldValidator? validator;

  const MCustomTextFormField({
    Key? key,
    required this.onChanged,
    this.width,
    this.value,
    this.hintText,
    this.inputFormatters,
    this.maxLength,
    this.keyboardType,
    this.counterText,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String _value = value ?? "";
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.brownGrey.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        maxLength: maxLength,
        keyboardType: keyboardType,
        cursorColor: AppColors.lightBlueGrey,
        decoration: InputDecoration(
          counterText: counterText ?? '',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.veryLightBlue,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.veryLightBlue,
            ),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: AppColors.lightBlueGrey),
        ),
        inputFormatters: inputFormatters,
        onChanged: (val) => onChanged(val),
        controller: TextEditingController()
          ..text = _value
          ..selection = TextSelection.collapsed(offset: _value.length),
        validator: validator,
      ),
    );
  }
}
