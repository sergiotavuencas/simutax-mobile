import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  late double width;
  late double height;

  Color get darkBlue => const Color.fromARGB(255, 4, 52, 92);
  Color get yellow => const Color.fromARGB(255, 255, 252, 0);
  Color get lightGrey => const Color.fromARGB(255, 246, 246, 246);
  Color get mediumGrey => const Color.fromARGB(255, 232, 232, 232);
  Color get darkGrey => const Color.fromARGB(255, 189, 189, 189);
  Color get iconColor => const Color.fromARGB(125, 4, 52, 92);

  double get xxSmall => 8;
  double get xSmall => 12;
  double get small => 16;
  double get medium => 20;
  double get large => 24;
  double get xLarge => 28;
  double get xxLarge => 32;

  TextStyle get groupStyle => GoogleFonts.dmSans(
      fontSize: medium, fontWeight: FontWeight.normal, color: Colors.white);
  TextStyle get progressStyle => GoogleFonts.shrikhand(
      fontSize: large, fontWeight: FontWeight.normal, color: darkBlue);
  TextStyle get inputStyle => TextStyle(
      fontSize: small, fontWeight: FontWeight.normal, color: Colors.black);
  TextStyle get descriptionStyle => TextStyle(
      fontSize: small, fontWeight: FontWeight.normal, color: Colors.black);
  TextStyle get labelStyle => TextStyle(
      fontSize: small, fontWeight: FontWeight.w700, color: Colors.black);
  TextStyle get buttonStyleBlue => TextStyle(
      fontSize: medium, fontWeight: FontWeight.w500, color: Colors.white);
  TextStyle get buttonStyleGrey =>
      TextStyle(fontSize: medium, fontWeight: FontWeight.w500, color: darkBlue);

  AppStyle(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  ButtonStyle createButtonTheme(Color backgroundColor) => ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        fixedSize: MaterialStateProperty.all<Size>(Size(width, 50)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      );
}
