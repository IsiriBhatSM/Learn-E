// lib/widgets/drawer_widget.dart
import 'package:flutter/material.dart';
import 'package:learn_e/pages/about_us_page.dart';
import 'package:learn_e/widgets/bookmarks_expansion_tile.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ── Logo ─────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 60, 16, 20),
            child: Image.asset(
              'assets/logo/learn-e_orange.png',
              height: 80,
              fit: BoxFit.contain,
            ),
          ),

          // ── About us ───────
          ListTile(
            title: const Text(
              'About us',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutUsPage()),
              );
            },
          ),

          // ── SPACER cause it looked bad ─────────────
          const SizedBox(height: 24), // 

          // ── Bookmarks (expansion) ─────────────────────
          const BookmarksExpansionTile(),
        ],
      ),
    );
  }
}