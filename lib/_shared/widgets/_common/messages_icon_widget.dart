import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:gtm/_shared/widgets/_common/messages_widget.dart';

class MessagesIconWidget extends StatelessWidget {
  const MessagesIconWidget({
    Key? key,
    required this.newMessages,
  }) : super(key: key);

  final bool newMessages;

  @override
  Widget build(BuildContext context) {
    final bool _isWeb = MediaQuery.of(context).size.width >= web;
    return Padding(
      padding: paddingSmall,
      child: InkWell(
        onTap: () => _isWeb
            ? {}
            : {
                // TODO: open messenger page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MessagesWidget(),
                  ),
                )
              },
        child: Padding(
          padding: paddingSmall,
          child: Stack(
            children: [
              Container(
                child: svgToIcon(
                  appImagesName: AppImages.messagesIcon,
                ),
              ),
              if (newMessages)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.paleGrey1),
                      color: AppColors.greenRaw,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
