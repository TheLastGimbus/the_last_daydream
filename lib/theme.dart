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
      displayMedium: _dark.textTheme.displayMedium!.copyWith(
        color: const Color(0xffffffff),
        fontSize: 48,
        fontWeight: FontWeight.w200,
      ),
      displayLarge: _dark.textTheme.displayLarge!.copyWith(
        color: const Color(0xffffffff),
        fontSize: 80,
        fontWeight: FontWeight.w200,
      ),
      bodyLarge: _dark.textTheme.bodyLarge!.copyWith(
        color: const Color(0xffffffff),
        fontSize: 20,
        fontWeight: FontWeight.w200,
      ),
    ),
    scaffoldBackgroundColor: const Color(0xFF000000),
  );
}
