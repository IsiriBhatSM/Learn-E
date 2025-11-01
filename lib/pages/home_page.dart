// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:learn_e/widgets/navigation_bar.dart';
import 'package:learn_e/widgets/category_search_bar.dart';
import 'package:learn_e/widgets/home_highlights.dart';
import 'package:learn_e/widgets/drawer_widget.dart';
import 'package:learn_e/EVA/floating_eva_button.dart';   // ← EVA button

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Image.asset(
          'assets/logo/learn-e_white.png',
          height: 32,   
          fit: BoxFit.contain,
        ),
        centerTitle: false, // Aligns logo to the left
        backgroundColor: Theme.of(context).primaryColor,
        
        elevation: 0,
      ),

      // --------------------------------------------------------------
      //  BODY – Stack with clipBehavior: Clip.none to allow overlay
      // --------------------------------------------------------------
      body: Stack(
        clipBehavior: Clip.none, // ← ALLOWS CHAT WINDOW TO OVERFLOW
        children: [
          // ----- SCROLLABLE CONTENT -----
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Highlights
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                  'Interesting facts',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
                const HomeHighlights(),

                // Categories
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Categories',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
                const CategorySearchBar(),

                // Optional space at bottom
                const SizedBox(height: 20),
              ],
            ),
          ),

          // ----- EVA BUTTON – fixed above nav bar -----
          const Positioned(
            bottom: 30,   // Matches chat window position
            right: 16,
            child: FloatingEVAButton(),
          ),
        ],
      ),

      // bottomNavigationBar: NavigationBarWidget(),
      endDrawer: DrawerWidget(),
    );
  }
}