// home_highlights.dart
import 'package:flutter/material.dart';
import 'package:learn_e/pages/program_detail_page.dart';
import 'package:learn_e/models/article.dart';
import 'package:learn_e/data/articles_data.dart';

class HomeHighlights extends StatefulWidget {
  const HomeHighlights({super.key});

  @override
  State<HomeHighlights> createState() => _HomeHighlightsState();
}

class _HomeHighlightsState extends State<HomeHighlights> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String getFirstFiveWords(String title) {
    final words = title.split(' ');
    if (words.length <= 5) {
      return title + ' ... tap to read more';
    }
    return words.sublist(0, 5).join(' ') + ' ... tap to read more';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: FutureBuilder<List<Article>>(
        future: ArticleService.fetchArticles(), // fetch all articles
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching highlights: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No highlights available.'));
          }

          // Randomly select 5 unique articles
          List<Article> highlightArticles = List<Article>.from(snapshot.data!);
          highlightArticles.shuffle();
          highlightArticles = highlightArticles.take(5).toList();

          return Scrollbar(
            controller: _scrollController,
            thickness: 4,
            radius: const Radius.circular(2),
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 10, left: 8, right: 8),
              itemCount: highlightArticles.length,
              itemBuilder: (context, index) {
                final article = highlightArticles[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProgramDetailsPage(article: article),
                        ),
                      );
                    },
                    child: Container(
                      width: 140,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          children: [
                            if (article.contents.isNotEmpty)
                              ...article.contents.map((content) {
                                if (content.type == ContentType.image) {
                                  return Image.network(
                                    content.data,
                                    width: 140,
                                    height: 120,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(child: CircularProgressIndicator());
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/geography.png',
                                        width: 140,
                                        height: 120,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  );
                                }
                                return const SizedBox.shrink();
                              }).toList()
                            else
                              Image.asset(
                                'assets/images/geography.png',
                                width: 140,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            Container(
                              color: Colors.black.withOpacity(0.4),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getFirstFiveWords(article.title),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
