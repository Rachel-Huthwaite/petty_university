import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const Color background = Color(0xFF0B0B12);
  static const Color surface = Color(0xFF1A1A26);
  static const Color accentGreen = Color(0xFF6FBF9A); 
  static const Color accentPurple = Color(0xFF8A7FBF); 
  static const Color textPrimary = Color(0xFFF5F5F7);
  static const Color textSecondary = Color(0xB3F5F5F7); 

  static ThemeData get themeData {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        surface: surface,
        primary: accentGreen,
        secondary: accentPurple,
      ),
      useMaterial3: true,
    );
  }


  // Space Grotesk — used for headers/buttons
  static TextStyle takeItTo = GoogleFonts.spaceGrotesk(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: textPrimary,
  );

  static TextStyle pettyUniversityTitle = GoogleFonts.spaceGrotesk(
    fontWeight: FontWeight.bold,
    fontSize: 32,
    color: textPrimary,
  );

  static TextStyle needOptionLabel = GoogleFonts.spaceGrotesk(
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: textPrimary,
  );

  static TextStyle otherFieldLabel = GoogleFonts.spaceGrotesk(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: textPrimary,
  );

  static TextStyle caseIdHeader = GoogleFonts.spaceMono(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: textPrimary,
  );

  static TextStyle caseStatusOpenClosed = GoogleFonts.spaceMono(
    fontStyle: FontStyle.italic,
    fontSize: 20,
    color: textSecondary,
  );

  static TextStyle screenDescription = GoogleFonts.spaceMono(
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    fontSize: 11,
    color: textSecondary,
  );

  static TextStyle userInputText = GoogleFonts.spaceGrotesk(
    fontSize: 10,
    color: textPrimary,
  );

  static TextStyle classifiedReceiptsHeader = GoogleFonts.spaceMono(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: textPrimary,
  );

  static TextStyle caseListId = GoogleFonts.spaceMono(
    fontWeight: FontWeight.bold,
    fontSize: 13,
    color: textPrimary,
  );

  static TextStyle caseListStatus = GoogleFonts.spaceMono(
    fontStyle: FontStyle.italic,
    fontSize: 13,
    color: textSecondary,
  );

  static TextStyle timerDisplay = GoogleFonts.spaceMono(
    fontWeight: FontWeight.bold,
    fontSize: 64,
    color: textPrimary,
  );

  static TextStyle resetComplete = GoogleFonts.spaceMono(
    fontWeight: FontWeight.bold,
    fontSize: 22,
    color: textPrimary,
  );
}
