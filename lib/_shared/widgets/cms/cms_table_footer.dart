import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';

class CmsTableFooter extends StatelessWidget {
  final List columnsWidth;
  const CmsTableFooter({
    Key? key,
    required this.columnsWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderColor = AppColors.blueGrey;
    var textColor = AppColors.blueGrey;
    var containerColor = AppColors.veryLightGrey;
    List<Widget> tableHeaderStart = [
      ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12.0),
        ),
        child: Container(
          height: 20,
          width: 20,
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: borderColor,
                width: 2.0,
              ),
              bottom: BorderSide(
                color: borderColor,
                width: 2.0,
              ),
            ),
          ),
        ),
      )
    ];

    List<Widget> tableHeaderEnd = [
      ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(12.0),
        ),
        child: Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: borderColor,
                width: 2.0,
              ),
              bottom: BorderSide(
                color: borderColor,
                width: 2.0,
              ),
            ),
          ),
        ),
      )
    ];
    List<Widget> tableColumns = tableHeaderStart +
        columnsWidth
            .asMap()
            .entries
            .map(((element) => buildColumnFooterWidget(
                  index: element.key,
                  borderColor: borderColor,
                  containerColor: containerColor,
                  textColor: textColor,
                  context: context,
                )))
            .toList() +
        tableHeaderEnd;
    return LayoutBuilder(
      builder: (context, constraints) => ConstrainedBox(
          constraints: BoxConstraints(minWidth: constraints.minWidth),
          child: Row(
            children: tableColumns,
          )),
    );
  }

  Widget buildColumnFooterWidget({
    required int index,
    required Color borderColor,
    required Color containerColor,
    required Color textColor,
    required context,
  }) {
    return columnsWidth[index] == 0
        ? Expanded(
            child: Container(
                height: 20,
                width: columnsWidth[index],
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: borderColor,
                      width: 2.0,
                    ),
                  ),
                )),
          )
        : Container(
            height: 20,
            width: columnsWidth[index],
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: borderColor,
                  width: 2.0,
                ),
              ),
            ));
  }
}
