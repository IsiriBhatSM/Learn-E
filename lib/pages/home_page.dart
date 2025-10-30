import 'package:flutter/material.dart';
import 'package:learn_e/widgets/navigation_bar.dart';
// import 'package:learn_e/pages/program_detail_page.dart';
// import 'package:learn_e/data/articles_data.dart';
// import 'package:learn_e/models/article.dart';
import 'package:learn_e/widgets/category_search_bar.dart';
import 'package:learn_e/widgets/home_highlights.dart';
import 'package:learn_e/widgets/drawer_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo/learn-e_white.png',
          height: 25,
        ),
        centerTitle: false, // false = align left
        elevation: 0,
        // title: const Text('Home'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Did you know ?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            const HomeHighlights(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            const CategorySearchBar(),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBarWidget(),
      endDrawer: DrawerWidget(),
    );
  }
}