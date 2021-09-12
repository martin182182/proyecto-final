import 'package:shared_preferences/shared_preferences.dart';

class ThemeM {
  static const themeMode = "MODE";
  static const dark      = "DARK";
  static const light     = "LIGHT";

  setTheme(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(themeMode, theme);
  }

  Future<String> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(themeMode) ?? light;
  }
}