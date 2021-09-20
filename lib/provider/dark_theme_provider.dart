import 'package:flutter/material.dart';
import 'package:flutter_default_code/models/dark_theme_preferences.dart';

class DarkThemeProvider with ChangeNotifier{

  DarkThemePreferences darkThemePreferences = DarkThemePreferences();

  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  set darkTheme(bool value){
    _darkTheme = value;
    darkThemePreferences.setDartTheme(value);
    notifyListeners();
  }

}