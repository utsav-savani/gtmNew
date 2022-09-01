import 'package:flutter/material.dart';
import 'package:gtm/_shared/shared.dart';

class CmsTableRow extends StatefulWidget {
  final Padding? padding;
  final List columns;
  final List<Widget> row;
  final bool isExpandable;
  final Widget? expandedWidget;
  final Widget actions;
  final Widget? editActions;
  final Widget? addActions;
  final bool editBool;
  final int itemIndex;
  final List? columnsWidth;
  final VoidCallback? onTapAction;
  const CmsTableRow({
    Key? key,
    this.padding,
    required this.columns,
    required this.row,
    required this.isExpandable,
    required this.editBool,
    this.expandedWidget,
    required this.actions,
    this.editActions,
    this.addActions,
    required this.itemIndex,
    this.columnsWidth,
    this.onTapAction,
  }) : super(key: key);

  @override
  State<CmsTableRow> createState() => _CmsTableRowState();
}

class _CmsTableRowState extends State<CmsTableRow> {
  var borderColor = AppColors.blueGrey;
  var textColor = AppColors.charcoalGrey;
  bool isExpanded = false;
  double rowHeight = 30;
  @override
  Widget build(BuildContext context) {
    Color rowColor = (widget.itemIndex % 2 == 0)
        ? AppColors.veryLightGrey
        : AppColors.paleGrey;

    List<Widget> tableHeaderStart = [
      Container(
        height: rowHeight,
        width: 20,
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: rowColor,
          border: Border(
            left: BorderSide(
              color: borderColor,
              width: 2.0,
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          setState(() => isExpanded = !isExpanded);
        },
        child: Container(
          decoration: BoxDecoration(
            color: rowColor,
          ),
          width: 30,
          height: rowHeight,
          child: Icon(
            widget.isExpandable
                ? isExpanded
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_right
                : Icons.stop_rounded,
          ),
        ),
      ),
    ];
    List<Widget> tableHeaderEnd = [
      Container(
        height: rowHeight,
        width: 20,
        decoration: BoxDecoration(
          color: rowColor,
          border: Border(
            right: BorderSide(
              color: borderColor,
              width: 2.0,
            ),
          ),
        ),
      ),
    ];
    List<Widget> tableColumns = tableHeaderStart +
        widget.row.asMap().entries.map(((element) {
          Widget child = element.key == widget.row.length - 1
              ? widget.editBool
                  ? Row(
                      children: [
                        widget.addActions ?? Container(),
                        widget.addActions != null ? width(20) : Container(),
                        widget.editActions ?? Container(),
                        widget.editActions != null ? width(20) : Container(),
                        widget.actions
                      ],
                    )
                  : GestureDetector(
                      onTap: widget.onTapAction,
                      child: element.value,
                    )
              : GestureDetector(
                  onTap: widget.onTapAction,
                  child: element.value,
                );
          return widget.columnsWidth?[element.key] == 0
              ? Expanded(
                  child: Container(
                    color: rowColor,
                    height: rowHeight,
                    padding: const EdgeInsets.all(4),
                    width: widget.columnsWidth?[element.key],
                    child: child,
                  ),
                )
              : Container(
                  color: rowColor,
                  height: rowHeight,
                  width: widget.columnsWidth?[element.key],
                  padding: const EdgeInsets.all(4),
                  child: child,
                );
        })).toList() +
        tableHeaderEnd;

    return LayoutBuilder(
      builder: (context, constraints) => ConstrainedBox(
          constraints: BoxConstraints(minWidth: constraints.minWidth),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: tableColumns,
              ),
              widget.isExpandable
                  ? Visibility(
                      visible: isExpanded,
                      child: widget.expandedWidget ??
                          Container(
                            height: 50,
                            color: Colors.black,
                          ),
                    )
                  : Container(),
            ],
          )),
    );
  }
}
