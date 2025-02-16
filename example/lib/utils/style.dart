import 'package:flutter/material.dart';

class Style {
  static final Color red = Color(0xFFFF0000);
  static final Color white = Color(0xFFFFFFFF);
  static final Color black = Color(0xFF000000);
  static final Color yellow = Color(0xFFF0BB29);
  static final Color beige = Color(0xFFE8C2A5);
  static final Color lightBlue = Color(0xFFB6D1DF);
  static final Color grey = Color(0xFFE7ECEB);
  static final Color darkBlue = Color(0xFF223F4A);

  static final ThemeData themeData = _buildTheme();

  static ThemeData _buildTheme() {
    ThemeData base = ThemeData.light();

    return base.copyWith(
        //accentColor: darkBlue,
        primaryColor: lightBlue,
        buttonTheme: base.buttonTheme.copyWith(
          buttonColor: lightBlue,
          textTheme: ButtonTextTheme.normal,
        ),
        floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
          elevation: 5,
          foregroundColor: white,
          backgroundColor: darkBlue,
        ),

        // Texts
        textTheme: _buildTextTheme(base.textTheme),
        primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
        //   accentTextTheme: _buildTextTheme(base.accentTextTheme),

        // Icons
        iconTheme: base.iconTheme.copyWith(
          color: darkBlue,
        ),
        primaryIconTheme: base.iconTheme.copyWith(
          color: darkBlue,
        ),

        // Input decorations
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),

        // Others
        scaffoldBackgroundColor: white,
        cardColor: white,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: darkBlue,
          selectionColor: lightBlue,
          selectionHandleColor: Colors.blue,
        ),

        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme(
            error: red,
            brightness: Brightness.light,
            primary: lightBlue,
            secondary: darkBlue,
            surface: white,
            onBackground: darkBlue,
            onSurface: darkBlue,
            onPrimary: darkBlue,
            onSecondary: darkBlue,
            onError: red,
            background: white),
        bottomAppBarTheme: BottomAppBarTheme(color: lightBlue));
  } // buildTheme

  static TextTheme _buildTextTheme(TextTheme base) {
    return base
        .copyWith(
          headlineSmall: base.headlineSmall!.copyWith(
            fontWeight: FontWeight.w500,
          ),
          titleLarge: base.titleLarge!.copyWith(
            fontSize: 18.0,
          ),
          bodySmall: base.bodySmall!.copyWith(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        )
        .apply(
          fontFamily: 'Rubik',
          displayColor: darkBlue,
          bodyColor: darkBlue,
        );
  } // buildTextTheme
} // Style
