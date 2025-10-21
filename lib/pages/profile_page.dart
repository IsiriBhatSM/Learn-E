/// A stateless widget that serves as the profile page, embedding the [ProfileWidget]
/// to display user profile information set during signup.
import 'package:flutter/material.dart';
import 'package:learn_e/widgets/profile_widget.dart';
import 'package:learn_e/widgets/navigation_bar.dart';

class ProfilePage extends StatelessWidget {
  /// Creates a [ProfilePage].
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    /// Builds the profile page scaffold with the [ProfileWidget] as its body
    /// and a navigation bar at the bottom.
    ///
    /// [context] is the BuildContext for the widget tree.
    /// Returns a [Scaffold] containing the read-only profile interface and navigation.
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: ProfileWidget()),
        ],
      ),
      bottomNavigationBar: NavigationBarWidget(),
    );
  }
}