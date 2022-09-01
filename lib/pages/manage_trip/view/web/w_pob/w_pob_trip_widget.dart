import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:gtm/theme/app_colors.dart';

class WPOBTripWidget extends StatefulWidget {
  const WPOBTripWidget({Key? key}) : super(key: key);

  @override
  State<WPOBTripWidget> createState() => _WPOBTripWidgetState();
}

class _WPOBTripWidgetState extends State<WPOBTripWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all()
      ),
      child: Column(
        children: [
          Row(
            children: [],
          ),
          DataTable2(columns: [
            getDataColumn('Surname'),
            getDataColumn('Given Name'),
            getDataColumn('Type'),
            getDataColumn('Passport'),
            getDataColumn('Pref'),
            getDataColumn('Nationality'),
            getDataColumn('Profile Icon'),
            getDataColumn(''),
            getDataColumn(''),
          ], rows: []),
        ],
      ),
    );
  }

  getDataColumn(String label) {
    return DataColumn2(
      label: Text(label,
          style: const TextStyle(color: AppColors.dataTableColumnHeaderColor)),
      size: ColumnSize.L,
    );
  }

}
