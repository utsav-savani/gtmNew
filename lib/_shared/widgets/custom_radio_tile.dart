import 'package:flutter/material.dart';

class CustomRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String? title;
  final Color? color;
  final ValueChanged<String?> onChanged;

  const CustomRadioListTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.title,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(title);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: _customRadioButton,
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = title == groupValue;
    return SizedBox(
      height: 122,
      width: 94,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      value.toString(),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: color,
                  child: Center(
                    child: Text(
                      title ?? '',
                      style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : null),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
