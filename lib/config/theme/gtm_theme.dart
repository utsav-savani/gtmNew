import 'package:flutter/material.dart';

/// Used for light theme
class GTMThemeLight {
  ///{@macro light}
  static ThemeData get lightTheme {
    //1
    return ThemeData(
      //2
      primarySwatch: Colors.purple,
      fontFamily: 'Montserrat', //3
      brightness: Brightness.light,
    );
  }
}

/// Used for dark theme
class GTMThemeDark {
  ///{@macro dark}
  static ThemeData get darkTheme {
    //1
    return ThemeData(
      //2
      primarySwatch: Colors.purple,
      fontFamily: 'Montserrat', //3
      brightness: Brightness.dark,
    );
  }
}
