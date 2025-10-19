// lib/home.dart
import 'package:flutter/material.dart';
import 'widgets/top_search_bar.dart';
import 'widgets/topic_row.dart';
import 'widgets/category_list.dart';
import 'widgets/bottom_nav.dart';
import 'widgets/right_drawer.dart';

class HomePage extends StatelessWidget {
  final String userName;
  const HomePage({Key? key, required this.userName}) : super(key: key);

  // Simple method returning latest facts (used by widgets)
  List<Map<String, String>> getLatestFacts() {
    return [
      {
        'title': 'Honeybees communicate with dances',
        'subtitle': 'Nature · ≈5 min read',
        'body': 'Worker bees use the waggle dance to tell hive mates where flowers are.'
      },
      {
        'title': 'A cloud can weigh over a million pounds',
        'subtitle': 'Science · ≈5 min read',
        'body': 'Clouds are full of water droplets; cumulonimbus can be very heavy!'
      },
      {
        'title': 'Octopuses have three hearts',
        'subtitle': 'Biology · ≈5 min read',
        'body': 'Two pump blood to the gills, one to the rest of the body.'
      },
    ];
  }

  // Simple method returning categories
  List<Map<String, String>> getCategories() {
    return [
      {'id': 'nature', 'title': 'Nature'},
      {'id': 'science', 'title': 'Science'},
      {'id': 'history', 'title': 'History'},
      {'id': 'tech', 'title': 'Technology'},
      {'id': 'culture', 'title': 'Culture'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    final facts = getLatestFacts();
    final categories = getCategories();

    return Scaffold(
      // right-side drawer
      endDrawer: RightDrawer(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // top: welcome, search, bell
            TopSearchBar(
              userName: userName,
              onSearchSubmitted: (q) {
                // {navigation/routing code goes here}
                // Example: Navigator.pushNamed(context, '/search', arguments: q);
              },
              onBellTap: () {
                // {navigation/routing code goes here}
                // Example: Navigator.pushNamed(context, '/notifications');
              },
              onDrawerTap: () {
                // open right drawer
                Scaffold.of(context).openEndDrawer();
              },
            ),

            const SizedBox(height: 10),

            // Horizontal topics showing latest facts
            SizedBox(
              height: 160,
              child: TopicRow(
                facts: facts,
                onFactTap: (fact) {
                  // {navigation/routing code goes here}
                  // Example: Navigator.pushNamed(context, '/factDetail', arguments: fact);
                },
              ),
            ),

            const SizedBox(height: 12),

            // Categories header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: const [
                  Text('Categories', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Categories list (scrollable column)
            Expanded(
              child: CategoryList(
                categories: categories,
                onCategoryTap: (categoryId) {
                  // {navigation/routing code goes here}
                  // Example: Navigator.pushNamed(context, '/category', arguments: categoryId);
                },
              ),
            ),
          ],
        ),
      ),

      // Simple bottom navigation
      bottomNavigationBar: const BottomNav(),
    );
  }
}
