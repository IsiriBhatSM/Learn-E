import 'package:flutter/material.dart';
// import 'package:learn_e/pages/home_page.dart';
// import 'package:learn_e/pages/profile_page.dart';
// import 'package:learn_e/pages/settings_page.dart';

class NavigationBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Access the app's theme
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      backgroundColor: theme.primaryColor, // Matches primaryOrange
      selectedItemColor: Colors.white, // White for selected icons and labels
      unselectedItemColor: Colors.white, // White for unselected icons and labels
      selectedIconTheme: IconThemeData(color: Colors.white), // Ensure selected icons are white
      unselectedIconTheme: IconThemeData(color: Colors.white), // Ensure unselected icons are white
      selectedLabelStyle: TextStyle(color: Colors.white), // Ensure selected labels are white
      unselectedLabelStyle: TextStyle(color: Colors.white), // Ensure unselected labels are white
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/profile');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/settings');
            break;
        }
      },
    );
  }
}