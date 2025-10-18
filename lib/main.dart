import 'package:flutter/material.dart';

final Color primaryOrange = Color(0xFFFC603F);
final Color white = Colors.white;
final Color black = Colors.black;

ThemeData learnETheme = ThemeData(
  primaryColor: primaryOrange,
  scaffoldBackgroundColor: white,
  fontFamily: 'Poppins', // clean and modern font
  appBarTheme: AppBarTheme(
    backgroundColor: primaryOrange,
    foregroundColor: white,
    elevation: 2,
    titleTextStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: white,
    ),
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: black,
      fontSize: 16,
    ),
    titleLarge: TextStyle(
      color: black,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryOrange,
      foregroundColor: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
);


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // TODO: Replace Scaffold with actual home screen (e.g., LoginPage) when created

    return MaterialApp(title: 'Learn-E', theme: learnETheme, home: Scaffold()
    );
  }
}
