import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/helpers.dart';

class BrowseWidget extends StatelessWidget {
  const BrowseWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          //TODO: drag and drop/browse
        },
        child: DottedBorder(
          color: AppColors.lightBlueGrey,
          radius: const Radius.circular(4.0),
          child: Container(
            color: AppColors.paleGrey,
            width: 124,
            height: 100,
            child: Column(children: [
              const Icon(
                Icons.cloud_upload_outlined,
                size: 36,
              ),
              appText('Drag and drop to upload',
                  fontSize: 10, color: AppColors.powderBlue),
              appText('or', fontSize: 10, color: AppColors.powderBlue),
              appText('Browse', fontSize: 16, color: AppColors.deepLilac),
              appText('to choose a file',
                  fontSize: 10, color: AppColors.powderBlue),
            ]),
          ),
        ),
      ),
    );
  }
}
