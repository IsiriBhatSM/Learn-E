import 'package:flutter/material.dart';
import '../widgets/category_search_bar.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/notification_button.dart';
// import '../theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Ensures consistent background
      appBar: AppBar(
        actions: [
          NotificationButton(),
        ],
      ),
      body: Column(
        children: [
          CategorySearchBar(),
          // Horizontal list for highlighted facts to allow easy scrolling
          Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to fact details page
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => FactDetailsPage()));
                  },
                  child: Container(
                    width: 120,
                    color: Colors.grey, // Temporary placeholder; replace with themed card design
                    child: Center(
                      child: Text(
                        'Fact $index',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Vertical list for category navigation
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  'Category $index',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onTap: () {
                  // Navigate to category facts list
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryFactsPage()));
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBarWidget(),
      endDrawer: DrawerWidget(),
    );
  }
}