import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';

class NotificationsIconWidget extends StatelessWidget {
  const NotificationsIconWidget({
    Key? key,
    required this.newNotifications,
  }) : super(key: key);

  final bool newNotifications;

  @override
  Widget build(BuildContext context) {
    final bool _isWeb = MediaQuery.of(context).size.width >= web;
    return Padding(
      padding: paddingSmall,
      child: InkWell(
        onTap: () {
          // TODO: User notification page
        },
        child: Padding(
          padding: paddingSmall,
          child: Stack(
            children: [
              Container(
                child: svgToIcon(
                  appImagesName: AppImages.notificationsIcon,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: newNotifications
                    ? Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.paleGrey1),
                            color: AppColors.greenRaw,
                            shape: BoxShape.circle),
                      )
                    : Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
