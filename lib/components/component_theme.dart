import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color colorsBlack = Color(0xFF000000);
const Color colorsBlackGray = Color.fromARGB(255, 27, 27, 27);
const Color colorPrimary = Color(0xFF3E004F);
const Color colorWhite = Color(0xFFFFFFFF);
const Color colorGray = Color(0xFFEFEFEF);
const Color colorTextGray = Color(0xFF585858);
const Color buttonGray = Color(0xFFDEDEDE);
const Color borderGray = Color(0xFFE1E1E1);
const Color textGray = Color(0xFF595959);
const Color darkThemeText = Color(0xFFEFEFEF);

final lightTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: colorPrimary,
  // primarySwatch: primaryCustomSwatch,
  brightness: Brightness.light,
  fontFamily: GoogleFonts.roboto().fontFamily,
  bottomSheetTheme:
      BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
  scaffoldBackgroundColor: Colors.white,
  textTheme:  const TextTheme(
    bodyLarge: TextStyle(),
    bodyMedium: TextStyle(),
  ).apply(
    bodyColor: colorsBlack,
    displayColor: colorsBlack,
  ),
  textSelectionTheme: const TextSelectionThemeData(cursorColor: colorPrimary), colorScheme: const ColorScheme.light()
      .copyWith(primary: colorPrimary, onPrimary: colorPrimary)
      .copyWith(
        primary: colorPrimary,
        secondary: colorPrimary,
        brightness: Brightness.light,
      ).copyWith(background: Colors.white),
);

final darkTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: colorPrimary,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: colorPrimary,
  ),
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(),
    bodyMedium: TextStyle(),
  ).apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
  fontFamily: GoogleFonts.roboto().fontFamily,
  bottomSheetTheme:
      BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
  scaffoldBackgroundColor: colorsBlack,
  textSelectionTheme: const TextSelectionThemeData(cursorColor: colorPrimary), colorScheme: const ColorScheme.dark()
      .copyWith(primary: colorPrimary, onPrimary: colorPrimary)
      .copyWith(
        secondary: colorPrimary,
        brightness: Brightness.dark,
      ).copyWith(background: colorsBlack),
);
