import 'package:flutter/material.dart';
// import '../theme.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          label: 'More',
        ),
      ],
      onTap: (selectedIndex) {
        switch (selectedIndex) {
          case 0:
            // Navigate to profile page
            // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
            break;
          case 1:
            // Navigate to settings page
            // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
            break;
          case 2:
            Scaffold.of(context).openEndDrawer();
            break;
        }
      },
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Theme.of(context).appBarTheme.foregroundColor,
      unselectedItemColor: Colors.grey,
    );
  }
}