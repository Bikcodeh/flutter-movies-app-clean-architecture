import 'package:flutter/material.dart';

ThemeData getTheme(bool darkMode) {
  return darkMode ? ThemeData.dark() : ThemeData.light();
}
