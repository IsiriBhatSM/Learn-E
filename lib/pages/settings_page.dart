// lib/pages/settings_page.dart
import 'package:flutter/material.dart';
import 'package:learn_e/pages/login_screen.dart';
import 'package:learn_e/widgets/navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:learn_e/theme_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Center(
              child: Text("Settings", style: TextStyle(fontSize: 40)),
            ),
            const SizedBox(height: 20),
            // SwitchListTile(
            //   title: const Text("Notifications"),
            //   value: _notificationsEnabled,
            //   onChanged: (v) => setState(() => _notificationsEnabled = v),
            // ),
            SwitchListTile(
              title: const Text("Dark Mode"),
              value: themeProvider.isDark,
              onChanged: (v) => themeProvider.toggleTheme(),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              ),
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
      // bottomNavigationBar: NavigationBarWidget(),
    );
  }
}