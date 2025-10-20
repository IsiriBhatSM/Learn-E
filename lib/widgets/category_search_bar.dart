import 'package:flutter/material.dart';
// import '../theme.dart';

class CategorySearchBar extends StatelessWidget {
  const CategorySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[200], // Temporary; replace with themed color if available
        ),
        onChanged: (searchQuery) {
          // Trigger search based on user input
          // Implement search logic here
        },
      ),
    );
  }
}