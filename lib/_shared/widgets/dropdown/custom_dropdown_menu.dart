import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  final List<String> items;
  final ValueChanged<String> itemCallBack;
  final String currentItem;

  const DropdownWidget(
    this.items,
    this.itemCallBack,
    this.currentItem,
  ) : super();

  @override
  State<StatefulWidget> createState() => _DropdownState(currentItem);
}

class _DropdownState extends State<DropdownWidget> {
  List<DropdownMenuItem<String>> dropDownItems = [];
  String currentItem;

  _DropdownState(this.currentItem);

  @override
  void initState() {
    super.initState();
    for (String item in widget.items) {
      dropDownItems.add(DropdownMenuItem(
        value: item,
        child: Text(
          item,
          // style: TextStyle(
          //   fontSize: 16,
          // ),
        ),
      ));
    }
  }

  @override
  void didUpdateWidget(DropdownWidget oldWidget) {
    if (currentItem != widget.currentItem) {
      setState(() {
        currentItem = widget.currentItem;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 6),
            child: const Text(''
                // widget.title,
                // style: appTheme.activityAddPageTextStyle,
                ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 10,
                  color: Color(0x19000000),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: currentItem,
                isExpanded: true,
                items: dropDownItems,
                onChanged: (selectedItem) => setState(() {
                  currentItem = selectedItem.toString();
                  widget.itemCallBack(currentItem);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
