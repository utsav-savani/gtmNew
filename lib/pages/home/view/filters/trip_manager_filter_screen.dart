import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gtm/_shared/shared.dart';

class TripManagerFilterScreen extends StatefulWidget {
  // final TripManagerFilter tripManagerFilter;
  const TripManagerFilterScreen({Key? key}) : super(key: key);

  @override
  State<TripManagerFilterScreen> createState() =>
      _TripManagerFilterScreenState();
}

class _TripManagerFilterScreenState extends State<TripManagerFilterScreen> {
  @override
  Widget build(BuildContext context) {
    // TripManagerFilter _filter = BlocProvider.of<HomeBloc>(context).;
    // print(_filter.fromDate());
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          height(24),
          const Text("filter screen"),
          // TextFormField(
          //   autovalidateMode: AutovalidateMode.always,
          //   enableInteractiveSelection: false,
          //   readOnly: true,
          //   decoration: InputDecoration(
          //     labelText: 'selectFromDate'.translate(),
          //     hintText: 'selectFromDate'.translate(),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //   ),
          //   onTap: () => _showFromDatePicker(),
          // ),
          // height(12),
          // TextFormField(
          //   autovalidateMode: AutovalidateMode.always,
          //   enableInteractiveSelection: false,
          //   readOnly: true,
          //   decoration: InputDecoration(
          //     labelText: 'selectToDate'.translate(),
          //     hintText: 'selectToDate'.translate(),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //   ),
          //   onTap: () => _showFromDatePicker(),
          // ),
        ],
      ),
    );
  }

  _showFromDatePicker() {
    return DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(2018, 3, 5),
        maxTime: DateTime(2019, 6, 7),
        onChanged: (date) {},
        onConfirm: (date) {},
        currentTime: DateTime.now(),
        locale: LocaleType.en);
  }
}
