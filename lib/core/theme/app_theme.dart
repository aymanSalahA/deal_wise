import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart'; 

class AppThemes {
 
  static ThemeData get darkTheme {
    const Color cardColor = AppColors.cardDark;
    
    return ThemeData(
      
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryBlue,
      scaffoldBackgroundColor: AppColors.backgroundDark, 
      cardColor: cardColor, 
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryBlue,
        secondary: AppColors.accentOrange,
        background: AppColors.backgroundDark, 
        surface: cardColor, 
        onSurface: AppColors.textLight,  
      ),

      
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundDark, 
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textLight),
        titleTextStyle: TextStyle(
          color: AppColors.textLight, 
          fontSize: 20, 
          fontWeight: FontWeight.bold
        ),
        
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,  
          statusBarBrightness: Brightness.dark,       
          statusBarColor: Colors.transparent,        
        ),
      ),

      // Text Theme
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.textLight),
        bodyMedium: TextStyle(color: AppColors.textLight),
        headlineLarge: TextStyle(color: AppColors.textLight, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: AppColors.textLight, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: AppColors.textLight), 
        labelLarge: TextStyle(color: AppColors.textLight),  
        labelMedium: TextStyle(color: AppColors.textLight),
      ),

      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackgroundDark, 
        hintStyle: const TextStyle(color: AppColors.textGrey), 
        contentPadding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: AppColors.inputBorderDark), 
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: AppColors.inputBorderDark), 
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2.0),
        ),
      ),
      
       
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.textLight, 
          backgroundColor: AppColors.primaryBlue, 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      
       
      cardTheme: CardThemeData(
        color: cardColor,  
        elevation: 0.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),

       
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.cardDark, 
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.textGrey,  
        elevation: 8,
        type: BottomNavigationBarType.fixed,  
      ),
      
      
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.inputBackgroundDark,  
        selectedColor: AppColors.primaryBlue,  
        labelStyle: TextStyle(color: AppColors.textLight),
        secondaryLabelStyle: TextStyle(color: AppColors.textLight),
        brightness: Brightness.dark,
      ),
    );
  }

  
  static ThemeData get lightTheme {
    const Color cardColor = AppColors.cardLight;

    return ThemeData(
     
      brightness: Brightness.light,
      primaryColor: AppColors.primaryBlue,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      cardColor: cardColor,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryBlue,
        secondary: AppColors.accentOrange,
        background: AppColors.backgroundLight,
        surface: cardColor,
        onSurface: AppColors.textDark,
      ),

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textDark),
        titleTextStyle: TextStyle(
          color: AppColors.textDark, 
          fontSize: 20, 
          fontWeight: FontWeight.bold
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,  
          statusBarBrightness: Brightness.light,     
          statusBarColor: Colors.transparent,        
        ),
      ),

      
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.textDark),
        bodyMedium: TextStyle(color: AppColors.textDark),
        headlineLarge: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: AppColors.textDark),
        labelLarge: TextStyle(color: AppColors.textDark),
        labelMedium: TextStyle(color: AppColors.textDark),
      ),

      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackgroundLight,
        hintStyle: const TextStyle(color: AppColors.textGrey),
        contentPadding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: AppColors.inputBorderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: AppColors.inputBorderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2.0),
        ),
      ),

       
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.textLight, 
          backgroundColor: AppColors.primaryBlue, 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      
       
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),

       
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.cardLight,  
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.textGrey,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      
     
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.inputBackgroundLight,
        selectedColor: AppColors.primaryBlue,
        labelStyle: TextStyle(color: AppColors.textDark),
        secondaryLabelStyle: TextStyle(color: AppColors.textDark),
        brightness: Brightness.light,
      ),
    );
  }
}