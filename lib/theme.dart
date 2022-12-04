import 'package:flutter/material.dart';

ThemeData get _dark => ThemeData.dark(useMaterial3: true);

ThemeData get darkTheme {
  return _dark.copyWith(
    colorScheme: _dark.colorScheme.copyWith(
      // pure amoled dark
      background: const Color(0xFF000000),
      surface: const Color(0xFF000000),
    ),
    textTheme: _dark.textTheme.copyWith(
      displayLarge: _dark.textTheme.displayLarge!.copyWith(
        fontSize: 64,
        fontWeight: FontWeight.w300,
      ),
      bodyLarge: _dark.textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.w200,
      ),
    ),
    scaffoldBackgroundColor: const Color(0xFF000000),
  );
}
