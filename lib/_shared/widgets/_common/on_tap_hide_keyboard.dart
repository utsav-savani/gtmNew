import 'package:flutter/material.dart';

class OnTapHideKeyBoard extends StatelessWidget {
  final Widget child;
  const OnTapHideKeyBoard({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: child,
    );
  }
}
