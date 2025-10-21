// home_highlights.dart
import 'package:flutter/material.dart';
import 'package:learn_e/pages/program_detail_page.dart'; // Fixed typo in import
import 'package:learn_e/models/article.dart';
import 'package:learn_e/data/articles_data.dart';

class HomeHighlights extends StatefulWidget {
  const HomeHighlights({super.key});

  @override
  State<HomeHighlights> createState() => _HomeHighlightsState();
}

class _HomeHighlightsState extends State<HomeHighlights> {
  final ScrollController _scrollController = ScrollController();
  late List<Article> _highlightArticles;

  @override
  void initState() {
    super.initState();
    // Randomly select 5 unique articles from allArticles
    _highlightArticles = List<Article>.from(allArticles);
    _highlightArticles.shuffle();
    _highlightArticles = _highlightArticles.take(5).toList();
  }

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
    // final theme = Theme.of(context);

    return SizedBox(
      height: 150,
      child: Scrollbar(
        controller: _scrollController,
        thickness: 4,
        radius: const Radius.circular(2),
        child: ListView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 10),
          children: [
            ...List.generate(
              _highlightArticles.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 12, left: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProgramDetailsPage(article: _highlightArticles[index]),
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
                          // Match ProgramDetailPage image logic
                          if (_highlightArticles[index].contents.isNotEmpty)
                            ..._highlightArticles[index].contents.map((content) {
                              if (content.type == ContentType.image) {
                                return Image.network(
                                  content.data,
                                  width: 140,
                                  height: 120,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    print('Image load error for ${_highlightArticles[index].title}: $error');
                                    return Image.asset(
                                      'assets/images/geography.png',
                                      width: 140,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                );
                              }
                              return const SizedBox.shrink(); // Skip non-image content
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
                                    getFirstFiveWords(_highlightArticles[index].title),
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
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}