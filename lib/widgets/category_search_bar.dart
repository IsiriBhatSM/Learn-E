import 'package:flutter/material.dart';
import 'package:learn_e/pages/program_list_page.dart';

class CategorySearchBar extends StatefulWidget {
  const CategorySearchBar({super.key});

  @override
  State<CategorySearchBar> createState() => _CategorySearchBarState();
}

class _CategorySearchBarState extends State<CategorySearchBar> {
  final TextEditingController _controller = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, String>> _allCategories = [
    {'title': 'Geography', 'image': 'assets/images/geography.png'},
    {'title': 'History', 'image': 'assets/images/history.png'},
    {'title': 'Philosophy', 'image': 'assets/images/philosophy.png'},
    {'title': 'Science', 'image': 'assets/images/science.png'},
    {'title': 'Technology', 'image': 'assets/images/technology.png'},
    {'title': 'Health', 'image': 'assets/images/health.jpg'}, // Updated to .jpg
  ];

  late List<Map<String, String>> _filteredCategories;

  @override
  void initState() {
    super.initState();
    _filteredCategories = List.from(_allCategories);
    _controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _controller.text.toLowerCase();
      if (_searchQuery.isEmpty) {
        _filteredCategories = List.from(_allCategories);
      } else {
        _filteredCategories = _allCategories.where((category) {
          final title = category['title']!.toLowerCase();
          return title.startsWith(_searchQuery);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Search categories',
              prefixIcon: const Icon(Icons.search, color: Color(0xFFFC603F)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            style: theme.textTheme.bodyMedium,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          height: 400,
          child: ListView.builder(
            itemCount: _filteredCategories.length,
            itemBuilder: (context, index) {
              final category = _filteredCategories[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProgramListPage(selectedCategory: category['title']!),
                    ),
                  ).then((value) {
                    setState(() {
                      _controller.clear();
                      _filteredCategories = List.from(_allCategories);
                    });
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
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
                          child: Image.asset(
                            category['image']!,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              print('Image load error for ${category['title']}: $error');
                              return Container(color: Colors.grey); // Fallback if image fails
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          category['title']!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}