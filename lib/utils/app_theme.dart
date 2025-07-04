
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppTheme {
  // Define your color palette
  static const Color primaryColor = Color(0xFF491B6D);
  static const Color errorColor = Colors.red;
  static const Color buttonColor = Color(0xFF491B6D);
  static const Color textBorderColor = Colors.grey;
  static const Color secondaryColor = Color(0xffE2E2E2);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF491B6D);

  

  static IconThemeData iconTheme = const IconThemeData(
    color: primaryColor,
    size: 24,
  );
  static ThemeData lightTheme() {
    return ThemeData(
      fontFamily: 'Poppins',
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
      ),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color.fromARGB(255, 6, 48, 87),
        selectedLabelStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Montserrat',
          fontSize: 14,
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.grey,
          fontFamily: 'Montserrat',
          fontSize: 12,
        ),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
      iconTheme: iconTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        iconTheme: iconTheme,
   
    
    
      ),
    textTheme: TextTheme(
  displayLarge: TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    color: textColor,
  ),
  displayMedium: TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: textColor,
  ),
  headlineSmall: TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    color: textColor,
  ),
  bodyLarge: TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.normal,
    color: textColor,
  ),
  bodyMedium: TextStyle(
    fontSize: 14.sp,
    color: Colors.black87,
  ),
  labelLarge: TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: primaryColor,
  ),
),

      buttonTheme: const ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }

  // A method to return ThemeData with customized dark Theme
  static ThemeData darkTheme() {
    return ThemeData(
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.black,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
      ),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
       
        textTheme: TextTheme(
  displayLarge: TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  headlineSmall: TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ),
  bodyLarge: TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: Colors.white70,
  ),
  bodyMedium: TextStyle(
    fontSize: 14.sp,
    color: Colors.white60,
  ),
  labelLarge: TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: secondaryColor,
  ),
), 
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        iconTheme: iconTheme.copyWith(color: Colors.white),
        titleTextStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
