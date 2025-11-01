// lib/widgets/categories.dart
import 'package:flutter/material.dart';
import 'package:learn_e/pages/program_list_page.dart';

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

    // --------------------------------------------------------------
    //  Category data – title + local asset path
    // --------------------------------------------------------------
    final categories = [
      {'title': 'Geography',   'image': 'assets/images/geography.png'},
      {'title': 'History',     'image': 'assets/images/history.png'},
      {'title': 'Philosophy',  'image': 'assets/images/philosophy.png'},
      {'title': 'Science',     'image': 'assets/images/science.png'},
      {'title': 'Technology',  'image': 'assets/images/technology.png'},
      {'title': 'Health',      'image': 'assets/images/health.jpg'},
    ];

    return SizedBox(
      height: 500, // fixed height → vertical scroll
      child: Scrollbar(
        controller: _scrollController,
        thickness: 4,
        radius: const Radius.circular(2),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final cat = categories[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Material(                     // <-- Material gives ripple + elevation
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  splashColor: const Color(0xFFFC603F).withOpacity(0.2),
                  highlightColor: const Color(0xFFFC603F).withOpacity(0.1),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProgramListPage(
                          selectedCategory: cat['title']!,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 112,                     // a bit taller → better touch target
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey.shade300, // subtle boundary
                        width: 1.1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.07),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // ----- IMAGE -----
                        ClipRRect(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(20),
                          ),
                          child: Image.asset(
                            cat['image']!,
                            width: 112,
                            height: 112,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: Colors.grey[200],
                              child: const Icon(Icons.image_not_supported,
                                  size: 40, color: Colors.grey),
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        // ----- TITLE -----
                        Expanded(
                          child: Text(
                            cat['title']!,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),

                        // ----- ARROW -----
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 22,
                            color: const Color(0xFFFC603F).withOpacity(0.8),
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
      ),
    );
  }
}