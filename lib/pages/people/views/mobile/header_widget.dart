import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';

class MHeaderButton extends StatefulWidget {
  const MHeaderButton({Key? key, required this.buttonText, required this.iconText}) : super(key: key);
  final String buttonText;
  final String iconText;
  @override
  State<MHeaderButton> createState() => _MHeaderButtonState();
}

class _MHeaderButtonState extends State<MHeaderButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        alignment: Alignment.center,
        decoration:
            BoxDecoration(color: AppColors.defaultColor, borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Row(children: [
          width(5),
          Container(
            decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Text(
                widget.iconText,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: AppColors.defaultColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                widget.buttonText,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: AppColors.charcoalGrey, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          width(5),
        ]),
      ),
    );
  }
}
