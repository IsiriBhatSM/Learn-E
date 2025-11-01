// lib/pages/feedback_page.dart
import 'package:flutter/material.dart';
import 'package:learn_e/models/article.dart';
import 'package:learn_e/pages/program_list_page.dart';
import 'package:confetti/confetti.dart';

class FeedbackPage extends StatefulWidget {
  final Article article;
  final String category;

  const FeedbackPage({
    super.key,
    required this.article,
    required this.category,
  });

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int _clarityRating = 0;
  int _interestRating = 0;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _submit() {
    _confettiController.play();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thank you for your feedback!'),
        backgroundColor: Color(0xFFFC603F),
        duration: Duration(seconds: 2),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      // REPLACE current route with ProgramListPage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ProgramListPage(selectedCategory: widget.category),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rate "${widget.article.title}"',
                  style: theme.textTheme.titleLarge?.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 32),

                // Question 1
                _buildRatingQuestion(
                  question: 'How easy was this to understand?',
                  rating: _clarityRating,
                  onChanged: (v) => setState(() => _clarityRating = v),
                ),
                const SizedBox(height: 32),

                // Question 2
                _buildRatingQuestion(
                  question: 'How interesting was this fact?',
                  rating: _interestRating,
                  onChanged: (v) => setState(() => _interestRating = v),
                ),
                const Spacer(),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (_clarityRating > 0 && _interestRating > 0) ? _submit : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFC603F),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      disabledBackgroundColor: Colors.grey[300],
                    ),
                    child: const Text(
                      'Submit Feedback',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Confetti at top-center
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              emissionFrequency: 0.05,
              numberOfParticles: 50,
              gravity: 0.2,
              colors: const [
                Colors.orange,
                Colors.red,
                Colors.yellow,
                Colors.green,
                Colors.blue,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingQuestion({
    required String question,
    required int rating,
    required ValueChanged<int> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (i) {
            return IconButton(
              icon: Icon(
                i < rating ? Icons.star : Icons.star_border,
                color: const Color(0xFFFC603F),
                size: 36,
              ),
              onPressed: () => onChanged(i + 1),
            );
          }),
        ),
      ],
    );
  }
}