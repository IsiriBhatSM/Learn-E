// lib/pages/profile_page.dart
import 'package:flutter/material.dart';
import 'package:learn_e/data/profile_data.dart';
import 'package:learn_e/widgets/articles_read_counter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _dob;

  @override
  void initState() {
    super.initState();
    _dob = Profile.dob;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white70 : Colors.black87;

    // HARDCODED ORANGE — 100% VISIBLE IN DARK MODE
    const Color orange = Color(0xFFFC603F);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // PROFILE CARD
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                color: theme.cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // PROFILE ICON — ORANGE, ALWAYS VISIBLE
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: orange.withOpacity(0.2),
                        child: Icon(
                          Icons.person,
                          size: 70,
                          color: orange, // ← HARD CODED
                        ),
                      ),
                      const SizedBox(height: 20),

                      // USERNAME
                      Text(
                        Profile.username ?? 'Guest User',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: orange,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // EMAIL
                      Text(
                        Profile.email ?? 'No email set',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 18,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // DIVIDER
                      Divider(color: theme.dividerColor, thickness: 1.2, indent: 20, endIndent: 20),
                      const SizedBox(height: 16),

                      // BIRTHDAY — ICON ORANGE, ALWAYS VISIBLE
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cake, color: orange, size: 28), // ← HARD CODED
                          const SizedBox(width: 12),
                          Text(
                            _dob ?? 'Not set',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // PROGRESS TITLE
              Text(
                'Your Progress',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: orange,
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ArticlesReadCounter(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}