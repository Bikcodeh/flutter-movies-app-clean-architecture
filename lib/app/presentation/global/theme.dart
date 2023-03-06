import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData getTheme(bool darkMode) {
  if (darkMode) {
    return ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkLight,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      canvasColor: AppColors.darkLight,
      switchTheme: SwitchThemeData(
        trackColor: MaterialStateProperty.all(
          Colors.lightBlue.withOpacity(0.5),
        ),
        thumbColor: MaterialStateProperty.all(
          Colors.blue,
        ),
      ),
    );
  } else {
    return ThemeData.light();
  }
}
