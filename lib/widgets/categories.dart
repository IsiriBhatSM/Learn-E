import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categories = [
      {'title': 'Geography', 'image': 'assets/images/geography.png'},
      {'title': 'History', 'image': 'assets/images/history.png'},
      {'title': 'Philosophy', 'image': 'assets/images/philosophy.png'},
      {'title': 'Science', 'image': 'assets/images/science.png'},
      {'title': 'Technology', 'image': 'assets/images/technology.png'},
      {'title':'Health','image': 'assets/images/health.jpg'},
    ];

    return SizedBox(
      height: 500,  // ← FIXED HEIGHT FOR VERTICAL SCROLL
      child: Scrollbar(
        controller: _scrollController,
        thickness: 4,  // ← THIN SCROLLBAR
        radius: const Radius.circular(2),
        child: ListView(
          controller: _scrollController,
          children: [
            ...List.generate(
              categories.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Row(
                  children: [
                    // IMAGE
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          categories[index]['image']!,
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // TEXT
                    Expanded(
                      child: Text(
                        categories[index]['title']!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),  // ← END PADDING
          ],
        ),
      ),
    );
  }
}