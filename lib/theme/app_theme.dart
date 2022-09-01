import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gtm/_shared/helpers/input_border_with_shadow.dart';
import 'package:gtm/_shared/shared.dart';
import 'package:material_color_gen/material_color_gen.dart';

class AppTheme {
  final Color _defaultColor = AppColors.defaultColor;
  final Color _blackColor = AppColors.blackColor;

  //final double _defaultFontSize = 12.0;
  final MaterialColor _primarySwatchColor = AppColors.blueBerryColor.toMaterialColor();
  final Color _secondaryColor = AppColors.secondaryColor;

  defaultTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: _primarySwatchColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: const TextStyle(
          color: AppColors.blackColor,
          fontSize: 20,
        ),
        iconTheme: const IconThemeData(color: AppColors.blackColor),
        shadowColor: AppColors.brownGrey.withOpacity(0.22),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: _defaultColor,
      ),
      textTheme: TextTheme(
        //bodyLarge: GoogleFonts.lato(color: _defaultColor),
        headline6: GoogleFonts.lato(color: _blackColor),
        headline5: GoogleFonts.lato(color: _blackColor),
        headline4: GoogleFonts.lato(color: _blackColor),
        headline3: GoogleFonts.lato(color: _blackColor),
        headline2: GoogleFonts.lato(color: _defaultColor),
        caption: GoogleFonts.lato(color: AppColors.alternateButtonColor),
        button: GoogleFonts.lato(color: _blackColor),
        headline1: GoogleFonts.lato(color: _defaultColor),
        subtitle1: GoogleFonts.lato(color: _blackColor, fontSize: spacing13),
        bodyText1: GoogleFonts.lato(color: _blackColor),
        overline: GoogleFonts.lato(color: _blackColor),
        // bodyMedium: GoogleFonts.lato(color: _defaultColor),
        // bodySmall: GoogleFonts.lato(color: _defaultColor),
        bodyText2: GoogleFonts.lato(color: _blackColor),
        // displayLarge: GoogleFonts.lato(color: _defaultColor),
        // displayMedium: GoogleFonts.lato(color: _defaultColor),
        // displaySmall: GoogleFonts.lato(color: _defaultColor),
        // headlineLarge: GoogleFonts.lato(color: _defaultColor),
        // headlineMedium: GoogleFonts.lato(color: _defaultColor),
        // headlineSmall: GoogleFonts.lato(color: _defaultColor),
        // labelLarge: GoogleFonts.lato(color: _defaultColor),
        // labelMedium: GoogleFonts.lato(color: _defaultColor),
        // labelSmall: GoogleFonts.lato(color: _defaultColor),
        subtitle2: GoogleFonts.lato(color: _blackColor),
        // titleLarge: GoogleFonts.lato(color: _defaultColor),
        // titleMedium: GoogleFonts.lato(color: _defaultColor),
        // titleSmall: GoogleFonts.lato(color: _defaultColor)
      ),
      backgroundColor: AppColors.whiteColor,
      cardTheme: const CardTheme(
        color: AppColors.whiteColor,
        shadowColor: AppColors.greyColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          /*  side: BorderSide(
            color: AppColors.greyColor,
            width: 2.0,
          ), */
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(AppColors.powderBlue),
        checkColor: MaterialStateProperty.all(AppColors.blueGrey),
        overlayColor: MaterialStateProperty.all(
          AppColors.powderBlue.withOpacity(0.2),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(spacing4),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        suffixIconColor: AppColors.blueGrey,
        prefixIconColor: AppColors.blueGrey,
        hintStyle: const TextStyle(
          color: AppColors.blueGrey,
        ),
        labelStyle: const TextStyle(
          fontSize: 14,
        ),
        floatingLabelStyle: const TextStyle(color: AppColors.blueGrey),
        contentPadding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 1,
            color: AppColors.redColor,
          ),
        ),
        focusedBorder: DecoratedInputBorder(
          child: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              width: 1,
              color: AppColors.lightBlue,
            ),
          ),
          shadow: const BoxShadow(
            color: Color.fromARGB(16, 141, 141, 141),
            blurRadius: 8,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ),
        focusedErrorBorder: DecoratedInputBorder(
          child: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              width: 1,
              color: AppColors.lightBlue,
            ),
          ),
          shadow: const BoxShadow(
            color: Color.fromARGB(16, 141, 141, 141),
            blurRadius: 8,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 1,
            color: AppColors.greyColor,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 1,
            color: AppColors.lightBlue,
          ),
        ),
        errorMaxLines: 1,
        iconColor: AppColors.powderBlue,
      ),
      drawerTheme: const DrawerThemeData(
        //elevation: 0,
        backgroundColor: AppColors.whiteColor,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.greyColor,
        //thickness: 1.0,
      ),
      errorColor: AppColors.redColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColors.blueBerryColor),
          foregroundColor:
              MaterialStateProperty.all<Color>(AppColors.whiteColor),
          minimumSize: MaterialStateProperty.all(const Size(132, 48)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.defaultColor,
      ),
      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(),
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: _primarySwatchColor,
      ).copyWith(
        secondary: _secondaryColor,
      ),
    );
  }
}
