import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';
import 'package:firebase_database/firebase_database.dart';

class ArticleService {
  static final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child(
      'articles'); // static Database reference for Firebase Realtime Database

  // Static method to fetch all articles from the firebase database
  static Future<List<Article>> fetchArticles() async {
    try {
      final snapshot = await _dbRef.get();

      if (snapshot.exists && snapshot.value != null) {
        final data = snapshot.value;

        if (data is List) {
          // if firebase returns a List
          return data.where((item) => item != null).map((item) {
            final value = Map<String, dynamic>.from(item as Map);

            // Safely convert contents
            if (value['contents'] is List) {
              value['contents'] = (value['contents'] as List)
                  .map((i) => Map<String, dynamic>.from(i as Map))
                  .toList();
            }

            return Article.fromJson(value);
          }).toList();
        } else if (data is Map) {
          // if firebase returns a Map
          return data.entries.map((entry) {
            final key = entry.key.toString();
            final value = Map<String, dynamic>.from(entry.value as Map);

            // Safely convert contents
            if (value['contents'] is List) {
              value['contents'] = (value['contents'] as List)
                  .map((i) => Map<String, dynamic>.from(i as Map))
                  .toList();
            }

            return Article.fromJson({'id': key, ...value});
          }).toList();
        } 
      } 
      return []; // fallback: empty list
    } catch (e) {
      print('Error fetching articles: $e');
      return [];
    }
  }

  // Method to fetch a single article by ID
  static Future<Article?> fetchArticleById(String id) async {
    try {
      final snapshot = await _dbRef.child(id).get();

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
      return Article.fromJson({'id': id, ...data});
      } else {
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
