import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeService {
  ThemeService._();

  static Color dominantLight = const Color(0xffFFF7D6); // #FFF7D6
  static Color primaryLight = const Color(0xff00C6B9); // #00C6B9
  static Color accentLight = const Color(0xff0A2239); // #0A2239
  static Color onDominantLight = const Color(0xFF272643); // #272643
  static Color onPrimaryLight = const Color(0xFF000000);
  static Color onAccentLight = const Color(0xFFFFFFFF);

  static Color dominantDark = const Color(0xFF48453C); // #A2ACBD
  static Color primaryDark = const Color(0xFF1B3F61); // #3E4756
  static Color accentDark = const Color(0xFF1F5F77); // #0A2239
  static Color textDark = const Color(0xffFBFAEE);
  static Color onDominantDark = const Color(0xFFFFFFFF);
  static Color onPrimaryDark = const Color(0xFFFFFFFF);
  static Color onAccentDark = const Color(0xFF000000);

  static ThemeData getTheme(
      {dominant, primary, accent, onDominant, onPrimary, onAccent}) {
    return ThemeData(
      primarySwatch: ThemeService.getMaterialColor(primary),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primary,
        secondary: accent,
        onPrimary: onPrimary,
        onSecondary: onAccent,
      ),
      fontFamily: GoogleFonts.fredoka().fontFamily,
      textTheme: TextTheme(
        headlineLarge:
            TextStyle(fontWeight: FontWeight.bold, color: onDominant),
        headlineMedium:
            TextStyle(fontWeight: FontWeight.bold, color: onDominant),
        headlineSmall:
            TextStyle(fontWeight: FontWeight.bold, color: onDominant),
        bodyLarge: TextStyle(color: onDominant),
        bodyMedium: TextStyle(color: onDominant),
        bodySmall: TextStyle(color: onDominant),
        titleLarge: TextStyle(color: onDominant),
        titleMedium: TextStyle(color: onDominant),
        titleSmall: TextStyle(color: onDominant),
        labelLarge: TextStyle(color: onDominant),
        labelMedium: TextStyle(color: onDominant),
        labelSmall: TextStyle(color: onDominant),
      ),
      iconTheme: IconThemeData(color: onDominant),
      scaffoldBackgroundColor: dominant,
      primaryColor: primary,
      primaryColorLight: primary,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accent,
        foregroundColor: onAccent,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: accent,
        selectedItemColor: onAccent,
        unselectedItemColor: primary,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(accent),
          foregroundColor: WidgetStatePropertyAll(onAccent),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(accent),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(accent),
          foregroundColor: WidgetStatePropertyAll(onAccent),
          shape: WidgetStatePropertyAll(
            ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: accent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: primary),
        ),
        hintStyle: TextStyle(
          color: onDominant.withOpacity(.5),
        ),
      ),
      dividerColor: accent,
      dividerTheme: DividerThemeData(color: accent),
    );
  }

  static MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }
}
