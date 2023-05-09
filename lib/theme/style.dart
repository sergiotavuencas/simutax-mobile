import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simutax_mobile/theme/app_style.dart';

class Style {
  late AppStyle appStyle;

  ThemeData appTheme(BuildContext context) {
    appStyle = AppStyle(context);

    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      inputDecorationTheme: _getInputTheme(),
      appBarTheme: _getAppBarTheme(),
    );
  }

  AppBarTheme _getAppBarTheme() => AppBarTheme(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: GoogleFonts.inter(
            fontSize: appStyle.large,
            color: appStyle.darkBlue,
            fontWeight: FontWeight.w800),
      );

  InputDecorationTheme _getInputTheme() => InputDecorationTheme(
        hintStyle:
            TextStyle(fontSize: appStyle.small, color: appStyle.darkGrey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          gapPadding: 3,
        ),
        filled: true,
        fillColor: appStyle.lightGrey,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          gapPadding: 3,
          borderSide: BorderSide(color: appStyle.mediumGrey, width: 2),
        ),
        labelStyle: TextStyle(
            fontSize: appStyle.small,
            color: appStyle.darkGrey,
            fontWeight: FontWeight.normal),
        floatingLabelStyle: TextStyle(
            fontSize: appStyle.medium,
            color: appStyle.darkBlue,
            fontWeight: FontWeight.bold),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          gapPadding: 3,
          borderSide: BorderSide(color: appStyle.darkBlue, width: 3),
        ),
      );
}
