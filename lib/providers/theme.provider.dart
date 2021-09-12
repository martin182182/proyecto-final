import 'package:chesslib_final/models/theme.model.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeM themePreference = ThemeM();
  String _theme = ThemeM.light;

  String get (theme){
    return _theme;
  }

  set setTheme(String theme){
    _theme = theme;
    themePreference.setTheme(theme);
    notifyListeners();
  }

  bool isDarkTheme(){
    return _theme == ThemeM.dark;
  } 

}