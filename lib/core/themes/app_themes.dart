import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class CustomTextStyle extends TextStyle {
  static TextStyle h1(Color color) {
    return GoogleFonts.roboto(
        fontSize: 44,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.5,
        textStyle: const TextStyle(height: 3));
  }

  static TextStyle h2(Color color) {
    return GoogleFonts.roboto(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.5,
        textStyle: const TextStyle(height: 1));
  }

  static TextStyle h3(Color color) {
    return GoogleFonts.roboto(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.5,
        textStyle: const TextStyle(height: 2));
  }

  static TextStyle h4(Color color) {
    return GoogleFonts.roboto(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.5,
        textStyle: const TextStyle(height: 1.5));
  }

  static TextStyle sub(Color color) {
    return GoogleFonts.roboto(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: color,
      letterSpacing: 0.5,
    );
  }

  static TextStyle subHeading(Color color) {
    return GoogleFonts.roboto(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: color,
      letterSpacing: 0.5,
    );
  }

  static TextStyle title(Color color) {
    return GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.5,
        textStyle: const TextStyle(height: 1.5));
  }

  static TextStyle heading() {
    return GoogleFonts.roboto(
      fontSize: 26,
      fontWeight: FontWeight.w700,
      color: AppColors.primaryDark,
    );
  }

  static TextStyle dictionaryTitle(Color color) {
    return GoogleFonts.roboto(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: color,
      letterSpacing: 0.5,
    );
  }

  static TextStyle tabTitle() {
    return GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    );
  }

  static TextStyle DIYtitle() {
    return GoogleFonts.roboto(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
      color: Colors.white,
    );
  }

  static TextStyle Categoriestitle() {
    return GoogleFonts.roboto(
      fontSize: 15,
      color: Colors.black,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    );
  }

  static TextStyle bodyBold(Color color) {
    return GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.5,
        textStyle: const TextStyle(height: 1.5));
  }

  static TextStyle large(Color color) {
    return GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color,
        letterSpacing: 0.5,
        textStyle: const TextStyle(height: 1.5));
  }

  static TextStyle medium(Color color) {
    return GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
        letterSpacing: 0.5,
        textStyle: const TextStyle(height: 1.5));
  }

  static TextStyle normal(Color color) {
    return GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
        letterSpacing: 0.5,
        textStyle: const TextStyle(height: 1.5));
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
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.5);
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
