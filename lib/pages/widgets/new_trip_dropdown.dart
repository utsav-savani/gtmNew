// TODO: need to update the value of global selected variable through bloc
import 'package:flutter/material.dart';

Padding newTripDropDown(BuildContext context, List<String> dropDownList,
    String hintText, String? selectedValue) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: StatefulBuilder(builder: (context, setState) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                border: Border.all(color: Colors.black, width: 0.5),
              ),
              width: MediaQuery.of(context).size.width,
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<String>(
                    focusColor: Colors.white,
                    value: selectedValue,
                    hint: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Text(hintText),
                    ),
                    items: dropDownList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value!;
                      });
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      );
    }),
  );
}
