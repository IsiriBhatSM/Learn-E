// lib/widgets/bookmarks_drawer_section.dart
import 'package:flutter/material.dart';
import 'package:learn_e/models/article.dart';
import 'package:learn_e/widgets/bookmark_list_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BookmarksDrawerSection extends StatefulWidget {
  const BookmarksDrawerSection({super.key});

  @override
  State<BookmarksDrawerSection> createState() => _BookmarksDrawerSectionState();
}

class _BookmarksDrawerSectionState extends State<BookmarksDrawerSection> {
  List<Article> _bookmarks = [];

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> bookmarkJsons = prefs.getStringList('bookmarked_articles') ?? [];
    setState(() {
      _bookmarks = bookmarkJsons
          .map((jsonStr) => Article.fromJson(jsonDecode(jsonStr)))
          .toList();
    });
  }

  Future<void> _removeBookmark(Article article) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> bookmarks = prefs.getStringList('bookmarked_articles') ?? [];
    final articleJson = jsonEncode(article.toJson());
    bookmarks.remove(articleJson);
    await prefs.setStringList('bookmarked_articles', bookmarks);
    _loadBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _bookmarks.isEmpty
          ? [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'No bookmarks yet.',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            ]
          : _bookmarks
              .map((article) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: BookmarkListItem(
                      article: article,
                      onRemove: () => _removeBookmark(article),
                    ),
                  ))
              .toList(),
    );
  }
}