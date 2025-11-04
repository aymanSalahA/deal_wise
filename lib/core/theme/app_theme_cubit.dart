import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

 
enum AppThemeState { light, dark }

class ThemeCubit extends Cubit<AppThemeState> {
  static const String _themeKey = 'current_app_theme';

  ThemeCubit() : super(AppThemeState.light) {
    _loadTheme();
  }

  
  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themeKey) ?? false;  
    emit(isDark ? AppThemeState.dark : AppThemeState.light);
  }

  
  void setDarkTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, true);
    emit(AppThemeState.dark);
  }

  
  void setLightTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, false);
    emit(AppThemeState.light);
  }

 
  void toggleTheme() {
    state == AppThemeState.light ? setDarkTheme() : setLightTheme();
  }
}