/// A stateful widget that serves as the main navigation hub for the Learn-E app,
/// managing a bottom navigation bar to switch between Home, Profile, and Settings pages.
import 'package:flutter/material.dart';
import 'package:learn_e/pages/home_page.dart';
import 'package:learn_e/pages/profile_page.dart';
import 'package:learn_e/pages/settings_page.dart';

class FirstPage extends StatefulWidget {
  /// Creates a [FirstPage].
  FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

/// The state class for [FirstPage], managing the selected index and page navigation.
class _FirstPageState extends State<FirstPage> {
  int _selectedIndex = 0;

  /// Updates the selected index to change the displayed page.
  ///
  /// [index] is the new index of the page to display.
  void _changeBottomNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Builds the main scaffold with a bottom navigation bar and dynamic page content.
    ///
    /// [context] is the BuildContext for the widget tree.
    /// Returns a [Scaffold] with the current page based on [_selectedIndex].
    // final theme = Theme.of(context);

    final List<Widget> _pages = [
      /// Home page widget.
      HomePage(),
      /// Profile page widget.
      ProfilePage(),
      /// Settings page widget.
      SettingsPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          /// Icon button to open the end drawer (currently logs out).
          IconButton(
            icon: Icon(Icons.more_horiz_outlined),
            onPressed: () {
              // Code to execute when the settings icon is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FirstPage()),
              );
              print("Logged out");
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _changeBottomNavBar,
        items: [
          /// Navigation item for the Home page.
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          /// Navigation item for the Profile page.
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          /// Navigation item for the Settings page.
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}