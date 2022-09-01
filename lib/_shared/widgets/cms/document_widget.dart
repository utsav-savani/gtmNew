import 'package:flutter/material.dart';
import 'package:gtm/_shared/helpers/helpers.dart';

class DocumentWidget extends StatelessWidget {
  const DocumentWidget(
      {Key? key,
      this.name,
      this.docId,
      this.storedName,
      required this.onDownload})
      : super(key: key);

  final String? name;
  final int? docId;
  final String? storedName;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 124,
        height: 104,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(4.0),
          ),
          border: Border.all(color: AppColors.lightBlueGrey, width: 2.0),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: svgToIcon(
                appImagesName: AppImages.documentSvg,
                height: 28,
                width: 28,
              ),
            ),
            Flexible(
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      height: 20,
                      padding: const EdgeInsets.all(2.0),
                      color: AppColors.lightBlueGrey,
                      child: appText(
                        name,
                        color: AppColors.whiteColor,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: onDownload,
                          child: const Icon(
                            Icons.file_download_outlined,
                            size: 18,
                            color: AppColors.lightBlueGrey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            //TODO: open file
                          },
                          child: const Icon(
                            Icons.remove_red_eye_outlined,
                            size: 18,
                            color: AppColors.lightBlueGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        //TODO: delete file
                      },
                      child: svgToIcon(
                        appImagesName: AppImages.trash,
                        height: 14,
                        width: 14,
                        color: AppColors.redColor,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
