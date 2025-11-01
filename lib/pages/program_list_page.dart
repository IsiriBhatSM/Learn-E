// lib/pages/program_list_page.dart
import 'package:flutter/material.dart';
import 'package:learn_e/pages/program_detail_page.dart';
import 'package:learn_e/data/articles_data.dart';
import '../models/article.dart';

class ProgramListPage extends StatefulWidget {
  const ProgramListPage({super.key, required this.selectedCategory});

  final String selectedCategory;

  @override
  State<ProgramListPage> createState() => _ProgramListPageState();
}

class _ProgramListPageState extends State<ProgramListPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Article> _allArticles = [];
  List<Article> _filteredArticles = [];

  @override
  void initState() {
    super.initState();
    _loadArticles();
    _searchController.addListener(_onSearchChanged);
  }

  Future<void> _loadArticles() async {
    final articles = await ArticleService.fetchArticlesByCategory(widget.selectedCategory);
    setState(() {
      _allArticles = articles;
      _filteredArticles = articles;
    });
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        _filteredArticles = _allArticles;
      } else {
        _filteredArticles = _allArticles.where((article) {
          // Get first text content (first line of article)
          final firstText = article.contents
              .where((c) => c.type == ContentType.text)
              .map((c) => c.data)
              .firstOrNull
              ?.split('\n')
              .first
              .toLowerCase();

          if (firstText == null) return false;

          return firstText.contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectedCategory),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // FULL-WIDTH SEARCH BAR
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for facts',
                  prefixIcon: const Icon(Icons.search, color: Color(0xFFFC603F)),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),

              // ARTICLE LIST
              Expanded(
                child: _filteredArticles.isEmpty && _searchController.text.isNotEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text(
                              'No articles found',
                              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                            ),
                            Text(
                              'Try searching in the first line',
                              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      )
                    : _filteredArticles.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: _filteredArticles.length,
                            itemBuilder: (context, index) {
                              final article = _filteredArticles[index];
                              return Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                  title: Text(
                                    article.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                    ),
                                  ),
                                  subtitle: Text(
                                    article.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 18,
                                    color: Color(0xFFFC603F),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProgramDetailsPage(
                                          article: article,
                                          category:widget.selectedCategory),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}