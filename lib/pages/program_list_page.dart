// program_list_page.dart
import 'package:flutter/material.dart';
import 'package:learn_e/pages/program_detail_page.dart';
import 'package:learn_e/data/articles_data.dart';
import '../models/article.dart';

class ProgramListPage extends StatelessWidget {
  const ProgramListPage({super.key, required this.selectedCategory});

  final String selectedCategory;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedCategory),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search articles...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.sort),
                    onPressed: () {
                      // TODO: Add sorting logic later
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {
                      // TODO: Add filter logic later
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: FutureBuilder<List<Article>>(
                  future:
                      ArticleService.fetchArticlesByCategory(selectedCategory),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child:
                            Text('Error fetching articles: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('No articles found.'),
                      );
                    }

                    final filteredArticles = snapshot.data!;

                    return ListView.builder(
                      itemCount: filteredArticles.length,
                      itemBuilder: (context, index) {
                        final article = filteredArticles[index];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 4),
                          child: ListTile(
                            title: Text(article.title),
                            subtitle: Text(article.description),
                            trailing:
                                const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProgramDetailsPage(article: article),
                                ),
                              );
                            },
                          ),
                        );
                      },
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
