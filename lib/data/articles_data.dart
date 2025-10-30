import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class ArticleService {
  static const String _baseUrl =
      'https://68fb4f9f94ec96066025965b.mockapi.io/Articles';

  // Method to fetch all articles from the MockAPI
  static Future<List<Article>> fetchArticles() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((jsonItem) => Article.fromJson(jsonItem)).toList();
      } else {
        throw Exception(
            'Failed to load articles. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching articles: $e');
      return [];
    }
  }

  // Method to fetch a single article by ID
  static Future<Article?> fetchArticleById(String id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$id'));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Article.fromJson(json);
      } else {
        print('Error: Status code ${response.statusCode}');
        return null; // fallback: null
      }
    } catch (e) {
      print('Exception: $e');
      return null; // fallback: null
    }
  }

  // Method to fetch articles by category
  static Future<List<Article>> fetchArticlesByCategory(String category) async {
    final allArticles = await fetchArticles();
    return allArticles.where((a) => a.category == category).toList();
  }
}
