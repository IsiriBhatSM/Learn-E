// lib/widgets/articles_read_counter.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ← ADD THIS

class ArticlesReadCounter extends StatefulWidget {
  const ArticlesReadCounter({super.key});

  @override
  State<ArticlesReadCounter> createState() => _ArticlesReadCounterState();
}

class _ArticlesReadCounterState extends State<ArticlesReadCounter> {
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _loadCount();
  }

  Future<void> _loadCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _count = prefs.getInt('articles_read_count') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isDark ? Colors.grey[800] : Colors.grey[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu_book, size: 32, color: theme.primaryColor),
            const SizedBox(height: 8),
            Text(
              '$_count',
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Facts Read',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}