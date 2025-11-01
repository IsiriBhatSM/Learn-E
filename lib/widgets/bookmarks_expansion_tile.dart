// lib/widgets/bookmarks_expansion_tile.dart
import 'package:flutter/material.dart';
import 'package:learn_e/models/article.dart';
// import 'package:learn_e/pages/program_detail_page.dart';
import 'package:learn_e/widgets/bookmark_list_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BookmarksExpansionTile extends StatefulWidget {
  const BookmarksExpansionTile({super.key});

  @override
  State<BookmarksExpansionTile> createState() => _BookmarksExpansionTileState();
}

class _BookmarksExpansionTileState extends State<BookmarksExpansionTile> {
  List<Article> _bookmarks = [];
  static const String _key = 'bookmarked_articles';

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsons = prefs.getStringList(_key) ?? [];
    setState(() {
      _bookmarks = jsons
          .map((j) => Article.fromJson(jsonDecode(j)))
          .toList();
    });
  }

  Future<void> _removeBookmark(Article article) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> list = prefs.getStringList(_key) ?? [];
    list.remove(jsonEncode(article.toJson()));
    await prefs.setStringList(_key, list);
    _loadBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        'Bookmarks',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
      expandedAlignment: Alignment.centerLeft,
      children: _bookmarks.isEmpty
          ? [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'No bookmarks yet.',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ]
          : _bookmarks
              .map((article) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: BookmarkListItem(
                      article: article,
                      onRemove: () => _removeBookmark(article),
                    ),
                  ))
              .toList(),
    );
  }
}