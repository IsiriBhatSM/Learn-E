// data/categories_data.dart
import 'package:firebase_database/firebase_database.dart';

class CategoryService {
  static final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  static Future<List<String>> fetchCategories() async {
    try {
      final snapshot = await _dbRef.child('categories').get();

      if (!snapshot.exists || snapshot.value == null) {
        print('No categories found in Firebase.');
        return [];
      }

      final value = snapshot.value;

      List<String> categories = [];

      if (value is List) {
        // When Firebase stored it as a List
        for (var item in value) {
          if (item != null && item is Map && item.containsKey('name')) {
            categories.add(item['name'].toString());
          }
        }
      } else if (value is Map) {
        // When Firebase stored it as a Map
        for (var entry in value.values) {
          if (entry is Map && entry.containsKey('name')) {
            categories.add(entry['name'].toString());
          }
        }
      }

      print('Categories fetched: $categories');
      return categories;
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }
}
