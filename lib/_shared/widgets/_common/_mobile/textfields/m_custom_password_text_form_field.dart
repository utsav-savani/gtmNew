import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtm/_shared/shared.dart';

class MCustomPasswordTextFormField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  final Function? onChanged;
  final Function? validator;
  final bool? isEnabled;
  final Widget? suffixIcon;
  final String? errorText;

  const MCustomPasswordTextFormField({
    Key? key,
    this.hintText,
    this.labelText,
    this.inputFormatters,
    this.onChanged,
    this.validator,
    this.isEnabled,
    this.suffixIcon,
    this.errorText,
  }) : super(key: key);

  @override
  State<MCustomPasswordTextFormField> createState() =>
      _MCustomPasswordTextFormFieldState();
}

class _MCustomPasswordTextFormFieldState
    extends State<MCustomPasswordTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
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
        obscureText: _obscureText,
        autovalidateMode: AutovalidateMode.always,
        enabled: widget.isEnabled ?? true,
        cursorColor: AppColors.lightBlueGrey,
        decoration: InputDecoration(
          counterText: '',
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
          hintText: widget.hintText,
          labelText: widget.labelText,
          hintStyle: const TextStyle(color: AppColors.lightBlueGrey),
          suffixIcon: InkWell(
            onTap: () {
              _obscureText = !_obscureText;
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: svgToIcon(
                  appImagesName: _obscureText
                      ? AppImages.eyeIcon
                      : AppImages.eyeFilledIcon,
                ),
              ),
            ),
          ),
        ),
        inputFormatters: widget.inputFormatters,
        onChanged: (val) =>
            (widget.onChanged != null ? widget.onChanged!(val) : null),
        validator: (val) =>
            (widget.validator != null ? widget.validator!(val) : null),
      ),
    );
  }
}
