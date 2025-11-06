// about_us_page.dart
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        // title: Text('About Us'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Learn-E',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Welcome to Learn-E, your gateway to exploring the world through knowledge! We are a passionate team dedicated to creating an engaging and educational platform that inspires curiosity and lifelong learning. Our app brings together a diverse range of topics, from the mysteries of nature to the innovations of technology, all designed to make learning accessible and enjoyable.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'We are thrilled to be a part of Excelerate\'s Flutter internship, where we’ve had the incredible opportunity to hone our skills, collaborate with talented peers, and build this app from the ground up. This journey has been filled with challenges and growth, allowing us to create a tool that we hope will empower users worldwide to expand their horizons.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Our mission is to foster a love for learning by providing high-quality, well-organized content that caters to all ages and interests. Whether you’re diving into historical events, exploring scientific breakthroughs, or reflecting on philosophical ideas, Learn-E is here to guide you every step of the way.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'This app was made by: Abrar, Isiri, Mainuddin, and Saba',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}