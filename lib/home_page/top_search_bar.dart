// lib/widgets/top_search_bar.dart
import 'package:flutter/material.dart';

class TopSearchBar extends StatelessWidget {
  final String userName;
  final void Function(String) onSearchSubmitted;
  final VoidCallback onBellTap;
  final VoidCallback onDrawerTap;

  const TopSearchBar({
    Key? key,
    required this.userName,
    required this.onSearchSubmitted,
    required this.onBellTap,
    required this.onDrawerTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Slight transparency for the search bar
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        children: [
          // Welcome text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome, $userName', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                // Search field with slight transparency
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      hintText: 'Search facts, keywords...',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                    ),
                    onSubmitted: onSearchSubmitted,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Bell icon
          GestureDetector(
            onTap: onBellTap,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.notifications_none),
            ),
          ),

          const SizedBox(width: 8),

          // Drawer button (three dots or menu)
          GestureDetector(
            onTap: onDrawerTap,
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
    );
  }
}
