import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordTextField extends StatefulWidget {
  final String fieldText;
  final String? hintText;
  final Widget? prefixIcon;
  final TextCapitalization? textCapitalization;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final Function? onChanged;
  final Function? validator;
  final bool? isEnabled;
  final Widget? suffixIcon;
  final String? errorText;

  const PasswordTextField({
    Key? key,
    required this.fieldText,
    this.prefixIcon,
    this.hintText,
    this.textCapitalization,
    this.textInputType,
    this.inputFormatters,
    this.onChanged,
    this.validator,
    this.isEnabled,
    this.suffixIcon,
    this.errorText,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      autovalidateMode: AutovalidateMode.always,
      enabled: widget.isEnabled ?? true,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.words,
      keyboardType: widget.textInputType ?? TextInputType.name,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        hintText: widget.hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        errorText: widget.errorText,
        suffixIcon: InkWell(
          onTap: () {
            _obscureText = !_obscureText;
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              _obscureText
                  ? Icons.remove_red_eye_outlined
                  : Icons.remove_red_eye_rounded,
            ),
          ),
        ),
        labelText: widget.fieldText,
      ),
      inputFormatters: widget.inputFormatters,
      onChanged: (val) =>
          (widget.onChanged != null ? widget.onChanged!(val) : null),
      validator: (val) =>
          (widget.validator != null ? widget.validator!(val) : null),
    );
  }
}
