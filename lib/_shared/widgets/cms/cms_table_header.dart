import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';

class CmsTableHeader extends StatelessWidget {
  final Padding? padding;
  final List columns;
  final List columnsWidth;
  const CmsTableHeader({
    Key? key,
    this.padding,
    required this.columns,
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
          topLeft: Radius.circular(12.0),
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
              top: BorderSide(
                color: borderColor,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
      Container(
        width: 30,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: borderColor,
              width: 2.0,
            ),
          ),
        ),
      ),
    ];

    List<Widget> tableHeaderEnd = [
      ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12.0),
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
              top: BorderSide(
                color: borderColor,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    ];
    List<Widget> tableColumns = tableHeaderStart +
        columns
            .asMap()
            .entries
            .map(((element) => buildColumnHeaderWidget(
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: tableColumns,
          )),
    );
  }

  Widget buildColumnHeaderWidget({
    required int index,
    required Color borderColor,
    required Color containerColor,
    required Color textColor,
    required context,
  }) {
    Widget child = Stack(
      clipBehavior: Clip.none,
      children: [
        Container(),
        Positioned(
          top: -10,
          child: Container(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
            color: containerColor,
            child: appText(
              columns[index],
              color: textColor,
            ),
          ),
        ),
      ],
    );
    return columnsWidth[index] == 0
        ? Expanded(
            child: Container(
                height: 20,
                width: columnsWidth[index],
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: borderColor,
                      width: 2.0,
                    ),
                  ),
                ),
                child: child),
          )
        : Container(
            height: 20,
            width: columnsWidth[index],
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: borderColor,
                  width: 2.0,
                ),
              ),
            ),
            child: child);
  }
}
