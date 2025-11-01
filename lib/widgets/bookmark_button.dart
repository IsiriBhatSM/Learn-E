// lib/widgets/bookmark_button.dart
import 'package:flutter/material.dart';
import 'package:learn_e/models/article.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BookmarkButton extends StatefulWidget {
  final Article article;

  const BookmarkButton({super.key, required this.article});

  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  bool _isBookmarked = false;
  static const int _maxBookmarks = 20;
  static const String _key = 'bookmarked_articles';

  @override
  void initState() {
    super.initState();
    _checkBookmarkStatus();
  }

  Future<void> _checkBookmarkStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> bookmarks = prefs.getStringList(_key) ?? [];
    final articleJson = jsonEncode(widget.article.toJson());

    setState(() {
      _isBookmarked = bookmarks.any((b) => b == articleJson);
    });
  }

  Future<void> _toggleBookmark() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> bookmarks = prefs.getStringList(_key) ?? [];
    final articleJson = jsonEncode(widget.article.toJson());

    if (_isBookmarked) {
      // Remove
      bookmarks.remove(articleJson);
      await prefs.setStringList(_key, bookmarks);
      setState(() => _isBookmarked = false);
      _showSnackBar('Removed from bookmarks');
    } else {
      // Add
      if (bookmarks.length >= _maxBookmarks) {
        _showLimitDialog();
        return;
      }
      bookmarks.add(articleJson);
      await prefs.setStringList(_key, bookmarks);
      setState(() => _isBookmarked = true);
      _showSnackBar('Bookmarked!');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: const Color(0xFFFC603F)),
    );
  }

  void _showLimitDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Bookmark Limit Reached'),
        content: const Text('You can only save up to 20 articles. Remove some to add new ones.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
        color: Colors.white,
      ),
      onPressed: _toggleBookmark,
    );
  }
}