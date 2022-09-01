import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';

class CancelEditSaveButtons extends StatefulWidget {
  const CancelEditSaveButtons({
    Key? key,
    required this.editBool,
    required this.updateObj,
    required this.onCancel,
    required this.onSave,
  }) : super(key: key);
  final bool editBool;
  final updateObj;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  @override
  State<CancelEditSaveButtons> createState() => _CancelEditSaveButtonsState();
}

class _CancelEditSaveButtonsState extends State<CancelEditSaveButtons> {
  @override
  Widget build(BuildContext context) {
    bool editBool = widget.editBool;
    var updateObj = widget.updateObj;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(spacing8),
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.powderBlue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(spacing6),
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size?>(
                  const Size(spacing128, spacing48),
                ),
              ),
              onPressed: () => widget.onCancel(),
              child: const Text(cancel)),
        ),
        Padding(
          padding: const EdgeInsets.all(spacing8),
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    editBool ? AppColors.greenRaw : null),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(spacing6),
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size?>(
                  const Size(spacing128, spacing48),
                ),
              ),
              onPressed: () {
                // if (editBool) {
                //   context.read<CompanyProfileCubit>().updateCompanyProfile(
                //       updateObj!,
                //       update: true,
                //       reset: false);
                // }
                widget.onSave();
              },
              child: Text(editBool ? save : edit)),
        )
      ],
    );
  }
}
