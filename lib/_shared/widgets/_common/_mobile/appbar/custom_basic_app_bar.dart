import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';

class CustomBasicAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final bool centerTitle;
  final List<Widget>? actions;
  CustomBasicAppBar({
    Key? key,
    this.title,
    this.actions,
    this.centerTitle = true,
  }) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: AppColors.brownGrey.withOpacity(0.28),
            offset: const Offset(0, 2.0),
            blurRadius: 4.0,
          )
        ]),
        child: AppBar(
          title: Text(title ?? ''),
          titleTextStyle: const TextStyle(
            color: AppColors.greyishBrown,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          centerTitle: centerTitle,
          backgroundColor: AppColors.whiteColor,
          leading: Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: svgToIcon(
                appImagesName: AppImages.menuIcon,
                width: 22,
                height: 22,
                color: AppColors.charcoalGrey,
              ),
            ),
          ),
          actions: actions,
        ),
      ),
      preferredSize: preferredSize,
    );
  }
}
