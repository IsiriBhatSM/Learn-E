/// A stateful widget that serves as the settings page, allowing users to toggle
/// notifications and dark mode, and log out.
///
/// This page includes a list view for settings options and a navigation bar at the bottom.
import 'package:flutter/material.dart';
import 'package:learn_e/pages/login_screen.dart';
import 'package:learn_e/widgets/navigation_bar.dart';

class SettingsPage extends StatefulWidget {
  /// Creates a [SettingsPage].
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

/// The state class for [SettingsPage], managing settings state such as notifications
/// and dark mode toggles.
class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkMode = false; // Local toggle only

  @override
  Widget build(BuildContext context) {
    /// Builds the settings page UI with a list of configurable options and a navigation bar.
    ///
    /// [context] is the BuildContext for the widget tree.
    /// Returns a [Scaffold] containing the settings interface and navigation.
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Center(
              child: Text(
                "Settings",
                style: TextStyle(fontSize: 40),
              ),
            ),

            // Notifications toggle
            SwitchListTile(
              title: Text("Notifications"),
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),

            // Dark mode toggle
            SwitchListTile(
              title: Text("Dark Mode"),
              value: _darkMode,
              onChanged: (value) {
                setState(() {
                  _darkMode = value;
                });
              },
            ),

            const SizedBox(height: 40),

            // Logout button
            ElevatedButton.icon(
              onPressed: () {
                /// Handles the logout action by navigating to the login screen.
                ///
                /// Replaces the current route with the login screen.
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBarWidget(),
    );
  }
}