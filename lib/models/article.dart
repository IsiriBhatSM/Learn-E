// article.dart
enum ContentType {
  text,
  image,
  video,
  youtube,
  reference,
}

class Content {
  final ContentType type;
  final String data;

  Content({required this.type, required this.data});

  factory Content.fromMap(Map<String, dynamic> map) {
    return Content(
      type: ContentType.values.byName(map['type']),
      data: map['data'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type.name,
      'data': data,
    };
  }
}

class Article {
  final String title;
  final String category;
  final String description;
  final List<Content> contents;

  Article({
    required this.title,
    required this.category,
    required this.description,
    required this.contents,
  });

  factory Article.fromMap(Map<String, dynamic> map) {
    List<Content> contentList = [];
    if (map['contents'] != null) {
      contentList = List<Map<String, dynamic>>.from(map['contents'])
          .map((c) => Content.fromMap(c))
          .toList();
    }

    return Article(
      title: map['title'],
      category: map['category'],
      description: map['description'],
      contents: contentList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      'description': description,
      'contents': contents.map((c) => c.toMap()).toList(),
    };
  }
}