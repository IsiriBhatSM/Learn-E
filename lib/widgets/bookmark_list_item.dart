// lib/widgets/bookmark_list_item.dart
import 'package:flutter/material.dart';
import 'package:learn_e/models/article.dart';
import 'package:learn_e/pages/program_detail_page.dart';

class BookmarkListItem extends StatelessWidget {
  final Article article;
  final VoidCallback onRemove;

  const BookmarkListItem({
    super.key,
    required this.article,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: article.contents.isNotEmpty &&
              article.contents.first.type == ContentType.image
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                article.contents.first.data,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.image, size: 50),
              ),
            )
          : const Icon(Icons.article, size: 50),
      title: Text(
        article.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(article.category),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline, color: Colors.red),
        onPressed: onRemove,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProgramDetailsPage(
              article: article,
              category: article.category,
            ),
          ),
        );
      },
    );
  }
}