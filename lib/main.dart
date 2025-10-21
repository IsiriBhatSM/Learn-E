import 'package:flutter/material.dart';
import 'package:learn_e/pages/home_page.dart';
import 'package:learn_e/pages/login_screen.dart';
import 'package:learn_e/pages/profile_page.dart';
import 'package:learn_e/pages/settings_page.dart'; // Added
import 'package:learn_e/pages/signup_screen.dart';
import 'package:learn_e/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learn-E',
      theme: learnETheme,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/settings': (context) => const SettingsPage(), // Added
      },
    );
  }
}