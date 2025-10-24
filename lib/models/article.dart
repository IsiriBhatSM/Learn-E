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

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      type: ContentType.values.byName(json['type']),
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'data': data,
    };
  }
}

class Article {
  final String id;
  final String title;
  final String category;
  final String description;
  final List<Content> contents;

  Article({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.contents,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    List<Content> contentList = [];
    if (json['contents'] != null) {
      contentList = List<Map<String, dynamic>>.from(json['contents'])
          .map((c) => Content.fromJson(c))
          .toList();
    }

    return Article(
      id: json['id'].toString(),
      title: json['title'],
      category: json['category'],
      description: json['description'],
      contents: contentList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'description': description,
      'contents': contents.map((c) => c.toJson()).toList(),
    };
  }
}
