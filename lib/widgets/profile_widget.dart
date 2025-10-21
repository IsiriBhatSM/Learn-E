/// A widget that displays a user's profile information, including
/// username, email, and date of birth, set during signup.
///
/// This widget is stateful to handle initial data loading but does not
/// allow editing after creation.
import 'package:flutter/material.dart';
import 'package:learn_e/data/profile_data.dart';

class ProfileWidget extends StatefulWidget {
  /// Creates a [ProfileWidget].
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

/// The state class for [ProfileWidget], managing the display of profile data.
class _ProfileWidgetState extends State<ProfileWidget> {
  String? _dob;
  String? _profilePhotoUrl;

  @override
  void initState() {
    /// Initializes the state by loading profile data from [Profile].
    super.initState();
    _dob = Profile.dob;
    // Note: Username and email are not stored in state as they are static in Profile
  }

  @override
  Widget build(BuildContext context) {
    /// Builds the profile widget UI with a centered column layout for viewing only.
    ///
    /// [context] is the BuildContext for the widget tree.
    /// Returns a [Widget] representing the read-only profile interface.
    final theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title "Profile" at top left
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "Profile",
                    style: theme.textTheme.titleLarge?.copyWith(fontSize: 36),
                  ),
                ),
                // Centered profile image below the title
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: _profilePhotoUrl != null
                        ? NetworkImage(_profilePhotoUrl!)
                        : null,
                    backgroundColor: Colors.grey[300],
                    child: _profilePhotoUrl == null
                        ? const Icon(Icons.person, size: 60, color: Colors.white70)
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                // Profile details below the image
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username: ${Profile.username ?? 'Not set'}",
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Email: ${Profile.email ?? 'Not set'}",
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Date of Birth: ${_dob ?? 'Not set'}",
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}