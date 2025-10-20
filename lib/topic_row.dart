// lib/widgets/topic_row.dart
import 'package:flutter/material.dart';

class TopicRow extends StatelessWidget {
  // facts: list of maps with title, subtitle, body
  final List<Map<String, String>> facts;
  final void Function(Map<String, String>) onFactTap;

  const TopicRow({super.key, required this.facts, required this.onFactTap});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      scrollDirection: Axis.horizontal,
      itemCount: facts.length,
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (context, index) {
        final fact = facts[index];
        return GestureDetector(
          onTap: () => onFactTap(fact),
          child: Container(
            width: 220,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Placeholder image area
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(child: Icon(Icons.image, size: 30, color: Colors.black26)),
                ),
                const SizedBox(height: 8),
                Text(
                  fact['title'] ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text(
                  fact['subtitle'] ?? '',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
