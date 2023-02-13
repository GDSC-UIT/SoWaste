import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class CustomTextStyle extends TextStyle {
  static TextStyle h1(Color color) {
    return GoogleFonts.roboto(
      fontSize: 44,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle h2(Color color) {
    return GoogleFonts.roboto(
      fontSize: 36,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle h3(Color color) {
    return GoogleFonts.roboto(
      fontSize: 30,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle h4(Color color) {
    return GoogleFonts.roboto(
      fontSize: 26,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle sub(Color color) {
    return GoogleFonts.roboto(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle title(Color color) {
    return GoogleFonts.roboto(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle bodyBold(Color color) {
    return GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle large(Color color) {
    return GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle medium(Color color) {
    return GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle normal(Color color) {
    return GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle boldButton(Color color) {
    return GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle button(Color color) {
    return GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle link(Color color) {
    return GoogleFonts.roboto(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle tinyText(Color color) {
    return GoogleFonts.roboto(
      fontSize: 7,
      fontWeight: FontWeight.w300,
      color: color,
    );
  }
}

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.primary,
    ),
  );
}
