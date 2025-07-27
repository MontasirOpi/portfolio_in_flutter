import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const primaryColor = Color(0xFF0A192F);
  static const secondaryColor = Color(0xFF64FFDA);
  static const textColor = Color(0xFFCCD6F6);
  static const lightTextColor = Color(0xFF8892B0);
  static const backgroundColor = Color(0xFF0A192F);
  static const cardColor = Color(0xFF112240);
  
  static ThemeData themeData = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: Color.fromARGB(255, 149, 167, 163),
      surface: cardColor,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme.copyWith(
        displayLarge: GoogleFonts.poppins(
          color: textColor,
          fontSize: 60.0,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.poppins(
          color: textColor,
          fontSize: 48.0,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: GoogleFonts.poppins(
          color: textColor,
          fontSize: 36.0,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: GoogleFonts.poppins(
          color: textColor,
          fontSize: 24.0,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: GoogleFonts.poppins(
          color: textColor,
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.poppins(
          color: textColor,
          fontSize: 16.0,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: lightTextColor,
          fontSize: 14.0,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: secondaryColor,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: secondaryColor, width: 2),
        ),
      ),
    ),
    cardTheme: CardThemeData(
      color: cardColor,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
} 