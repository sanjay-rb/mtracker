import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeService {
  static Color dominantLight = const Color(0xffFBFAEE);

  static Color dominantDark = const Color(0xff242424);

  static Color secondaryLight = const Color(0xff84E296);

  static Color secondaryDark = const Color(0xff1B742B);

  static Color accentLight = const Color(0xffDC602E);

  static Color accentDark = const Color(0xffDE6C3F);

  static ThemeData getLightTheme(context) {
    ThemeData lightTheme = ThemeData(
      primarySwatch: getMaterialColor(dominantLight),
      brightness: Brightness.light,
      primaryColor: dominantLight,
      colorScheme: Theme.of(context).colorScheme.copyWith(
            brightness: Brightness.light,
            primary: dominantLight,
            secondary: secondaryLight,
            tertiary: accentLight,
            onPrimary: Colors.black,
            onSecondary: Colors.white,
          ),
      scaffoldBackgroundColor: dominantLight,
      textTheme: GoogleFonts.fredokaTextTheme(
        Theme.of(context).textTheme,
      ),
    );
    return lightTheme;
  }

  static ThemeData getDarkTheme(context) {
    ThemeData darkTheme = ThemeData(
      primarySwatch: getMaterialColor(dominantDark),
      brightness: Brightness.dark,
      primaryColor: dominantDark,
      colorScheme: Theme.of(context).colorScheme.copyWith(
            brightness: Brightness.dark,
            primary: dominantDark,
            secondary: secondaryDark,
            tertiary: accentDark,
            onPrimary: Colors.white,
            onSecondary: Colors.black,
          ),
      scaffoldBackgroundColor: dominantDark,
      textTheme: GoogleFonts.fredokaTextTheme(
        Theme.of(context).textTheme,
      ),
    );
    return darkTheme;
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
