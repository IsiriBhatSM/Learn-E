// lib/widgets/category_search_bar.dart
import 'package:flutter/material.dart';
import 'package:learn_e/pages/program_list_page.dart';
import '../data/categories_data.dart';

class CategorySearchBar extends StatefulWidget {
  const CategorySearchBar({super.key});

  @override
  State<CategorySearchBar> createState() => _CategorySearchBarState();
}

class _CategorySearchBarState extends State<CategorySearchBar> {
  final TextEditingController _controller = TextEditingController();
  String _searchQuery = '';
  List<String>  _allCategories = [];
  List<String> _filteredCategories = [];
  bool _isLoading = true;


  // final List<Map<String, String>> _allCategories = [
  //   {'title': 'Geography', 'image': 'assets/images/geography.png'},
  //   {'title': 'History', 'image': 'assets/images/history.png'},
  //   {'title': 'Philosophy', 'image': 'assets/images/philosophy.png'},
  //   {'title': 'Science', 'image': 'assets/images/science.png'},
  //   {'title': 'Technology', 'image': 'assets/images/technology.png'},
  //   {'title': 'Health', 'image': 'assets/images/health.jpg'}, // Updated to .jpg
  // ];

  // late List<Map<String, String>> _filteredCategories;

  @override
  void initState() {
    super.initState();
    _loadCategories();
    // _filteredCategories = List.from(_allCategories);
    _controller.addListener(_onSearchChanged);
  }

  Future<void> _loadCategories() async {
    final categories = await CategoryService.fetchCategories();
    setState(() {
      _allCategories = categories;
      _filteredCategories = List.from(categories);
      _isLoading = false;
    });
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
        _filteredCategories = _allCategories
            .where((category) => category.toLowerCase().startsWith(_searchQuery))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_filteredCategories.isEmpty) {
      return const Center(child: Text('No categories found.'));
    }

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
          height: 458,
          child: ListView.builder(
            itemCount: _filteredCategories.length,
            itemBuilder: (context, index) {
              final raw = _filteredCategories[index];
              // final title1 = raw is String ? raw : (raw is Map && raw.contains('name') ? raw['name'].toString(): 'Unknown');
              final title = _filteredCategories[index];
              final imagepath = _getImageForCategory(title);
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProgramListPage(selectedCategory: title),
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
                            imagepath,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              print('Image load error for $title: $error');
                              return Container(color: Colors.grey); // Fallback if image fails
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          title,
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

  //Helper to match Firebase category names with local images
  String _getImageForCategory(String title) {
    switch (title.toLowerCase()) {
      case 'geography':
        return 'assets/images/geography.png';
      case 'history':
        return 'assets/images/history.png';
      case 'philosophy':
        return 'assets/images/philosophy.png';
      case 'science':
        return 'assets/images/science.png';
      case 'technology':
        return 'assets/images/technology.png';
      case 'health':
        return 'assets/images/health.jpg';
      default:
        return 'assets/images/default.jpg';
    }
  }
}