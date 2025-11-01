// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn_e/theme_provider.dart'; // ← Your file next to main.dart
import 'package:learn_e/pages/first_page.dart';
import 'package:learn_e/pages/login_screen.dart';
import 'package:learn_e/pages/signup_screen.dart';
import 'package:learn_e/pages/home_page.dart';
import 'package:learn_e/pages/profile_page.dart';
import 'package:learn_e/pages/settings_page.dart';
import 'package:learn_e/pages/program_list_page.dart';
import 'package:learn_e/pages/program_detail_page.dart';
import 'package:learn_e/pages/feedback_page.dart';
import 'package:learn_e/pages/about_us_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const LearnEApp(),
    ),
  );
}

class LearnEApp extends StatelessWidget {
  const LearnEApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Learn-E',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.theme,
          initialRoute: '/login',
          routes: {
            '/login': (context) =>  LoginScreen(),
            '/signup': (context) => const SignUpScreen(),
            '/home': (context) => const FirstPage(), // Your main navigation hub
            '/profile': (context) => const ProfilePage(),
            '/settings': (context) => const SettingsPage(),
            '/about': (context) => const AboutUsPage(),
            // ProgramListPage and ProgramDetailsPage are pushed manually
          },
          onGenerateRoute: (settings) {
            // Handle dynamic routes if needed
            return null;
          },
        );
      },
    );
  }
}