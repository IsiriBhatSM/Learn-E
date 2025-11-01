// lib/widgets/finish_reading_button.dart
import 'package:flutter/material.dart';
import 'package:learn_e/models/article.dart';
import 'package:learn_e/pages/feedback_page.dart';

class FinishReadingButton extends StatelessWidget {
  final Article article;
  final String category;
  final VoidCallback? onPressed;

  const FinishReadingButton({
    super.key,
    required this.article,
    required this.category,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () async {
            onPressed?.call(); // ← Run counter increment
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => FeedbackPage(article: article, category: category),
              ),
            );
          },
          icon: const Icon(Icons.check_circle_outline),
          label: const Text(
            'Finish Reading',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFC603F),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}