// lib/widgets/right_drawer.dart
import 'package:flutter/material.dart';

class RightDrawer extends StatelessWidget {
  const RightDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const ListTile(title: Text('Menu', style: TextStyle(fontWeight: FontWeight.w600))),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('FAQs'),
              onTap: () {
                // {navigation/routing code goes here}
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // {navigation/routing code goes here}
                Navigator.of(context).pop();
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text('v1.0', style: TextStyle(color: Colors.grey.shade500)),
            )
          ],
        ),
      ),
    );
  }
}
