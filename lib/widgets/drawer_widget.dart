import 'package:flutter/material.dart';
// import '../theme.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Theme.of(context).appBarTheme.foregroundColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: Text('FAQ', style: Theme.of(context).textTheme.bodyMedium),
            onTap: () {
              // Show FAQ content
              // Navigator.push(context, MaterialPageRoute(builder: (context) => FAQPage()));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Logout', style: Theme.of(context).textTheme.bodyMedium),
            onTap: () {
              // Perform logout action
              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}