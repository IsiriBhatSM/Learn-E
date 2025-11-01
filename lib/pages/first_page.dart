// lib/pages/first_page.dart
import 'package:flutter/material.dart';
import 'package:learn_e/pages/home_page.dart';
import 'package:learn_e/pages/profile_page.dart';
import 'package:learn_e/pages/settings_page.dart';
import 'package:learn_e/widgets/navigation_bar.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int _selectedIndex = 0;

  // These pages have NO bottomNavigationBar inside them
  static const List<Widget> _pages = [
    HomePage(),
    ProfilePage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body switches between Home, Profile, Settings
      body: _pages[_selectedIndex],

      // ONE AND ONLY NAV BAR — controlled here
      bottomNavigationBar: NavigationBarWidget(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}