// lib/pages/program_detail_page.dart
import 'package:flutter/material.dart';
import 'package:learn_e/models/article.dart';
import 'package:learn_e/widgets/finish_reading_button.dart';
import 'package:learn_e/widgets/bookmark_button.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ← ADD THIS

class ProgramDetailsPage extends StatelessWidget {
  final Article article;
  final String category;

  const ProgramDetailsPage({
    super.key,
    required this.article,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          BookmarkButton(article: article),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(article.title, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 16),
                    Text(article.description, style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 16),
                    ...article.contents.map((content) {
                      if (content.type == ContentType.text) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(content.data, style: Theme.of(context).textTheme.bodyMedium),
                        );
                      } else if (content.type == ContentType.image) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Image.network(
                            content.data,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) => Container(
                              height: 100,
                              color: Colors.grey,
                              child: const Center(child: Text('Image failed')),
                            ),
                          ),
                        );
                      } else if (content.type == ContentType.video || content.type == ContentType.youtube) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            'Video: ${content.data}',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                        );
                      } else if (content.type == ContentType.reference) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            'Reference: ${content.data}',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),

          // FINISH READING BUTTON
          FinishReadingButton(
            article: article,
            category: category,
            onPressed: () async {
              // ← INCREMENT ARTICLES READ COUNT
              final prefs = await SharedPreferences.getInstance();
              final current = prefs.getInt('articles_read_count') ?? 0;
              await prefs.setInt('articles_read_count', current + 1);
            },
          ),
        ],
      ),
    );
  }
}