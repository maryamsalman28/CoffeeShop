import 'package:flutter/material.dart';
import 'package:fluttertest/themes/dark_theme.dart';
import 'package:fluttertest/themes/light_theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightTheme;

  ThemeData get themedata => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

void toggleTheme(){
  if (_themeData == lightTheme) {
    themeData = darkTheme;
  } else {
    themeData = lightTheme;
  }
}


}