import 'package:flutter/material.dart';
import 'package:learn_e/models/article.dart';

class ProgramDetailsPage extends StatelessWidget {
  final Article article; // Changed to accept Article object

  const ProgramDetailsPage({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        backgroundColor: Theme.of(context).primaryColor, // Matches primaryOrange
        foregroundColor: Colors.white, // Matches theme
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                article.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              ...article.contents.map((content) {
                if (content.type == ContentType.text) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      content.data,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                } else if (content.type == ContentType.image) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Image.network(
                      content.data,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey,
                          height: 100,
                          child: const Center(child: Text('Image failed to load')),
                        );
                      },
                    ),
                  );
                } else if (content.type == ContentType.video || content.type == ContentType.youtube) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'Video: ${content.data}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  );
                } else if (content.type == ContentType.reference) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'Reference: ${content.data}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}