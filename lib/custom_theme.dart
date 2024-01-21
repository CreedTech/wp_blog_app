import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wp_blog_app/const_values.dart';

ThemeData buildLightTheme() => ThemeData.light().copyWith(
      cardColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: defaultBlack,
      ),
      cardTheme: const CardTheme(
        color: Colors.white,
      ),
      dialogTheme: const DialogTheme(
        backgroundColor: defaultWhite,
      ),
      dividerColor: defaultWhite,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0.0,
        color: defaultWhite,
        iconTheme: IconThemeData(
          color: Colors.grey[900],
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        toolbarTextStyle: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ).bodyMedium,
        titleTextStyle: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ).titleLarge,
      ),
      textTheme: Typography.blackCupertino,
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: Colors.grey[800])
          .copyWith(background: Colors.grey[100]),
    );

ThemeData buildDarkTheme() => ThemeData.dark().copyWith(
      cardColor: Colors.grey[850],
      scaffoldBackgroundColor: darkColor,
      dividerColor: defaultBlack,
      iconTheme: const IconThemeData(
        color: defaultWhite,
      ),
      cardTheme: CardTheme(
        color: cardColor,
      ),
      dialogTheme: const DialogTheme(
        backgroundColor: defaultBlack,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0.0,
        color: Colors.grey[900],
        iconTheme: IconThemeData(
          color: Colors.grey[400],
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        toolbarTextStyle: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ).bodyMedium,
        titleTextStyle: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ).titleLarge,
      ),
      textTheme: Typography.whiteCupertino,
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: Colors.grey[400])
          .copyWith(background: Colors.grey[900]),
    );
