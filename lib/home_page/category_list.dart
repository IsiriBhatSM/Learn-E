// lib/widgets/category_list.dart
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  // categories: list of maps with id and title
  final List<Map<String, String>> categories;
  final void Function(String categoryId) onCategoryTap;

  const CategoryList({Key? key, required this.categories, required this.onCategoryTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      itemCount: categories.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final cat = categories[index];
        return InkWell(
          onTap: () => onCategoryTap(cat['id']!),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                // simple icon placeholder
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.book, size: 22, color: Colors.black26),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    cat['title'] ?? '',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        );
      },
    );
  }
}
