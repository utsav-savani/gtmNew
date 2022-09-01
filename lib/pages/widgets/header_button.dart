import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/helpers.dart';
import 'package:gtm/theme/app_colors.dart';

class HeaderButton extends StatelessWidget {
  final String buttonText;
  final String iconText;
  final Function onTap;
  final bool isClicked;
  const HeaderButton({
    Key? key,
    required this.buttonText,
    required this.iconText,
    required this.onTap,
    required this.isClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: isClicked ? AppColors.defaultColor : Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Row(children: [
            width(5),
            Container(
              decoration: BoxDecoration(
                  color:
                      isClicked ? Colors.white : AppColors.alternateButtonColor,
                  shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text(
                  iconText,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: isClicked ? AppColors.defaultColor : Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  buttonText,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: isClicked ? Colors.white : AppColors.charcoalGrey,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            width(5),
          ]),
        ),
      ),
    );
  }
}
