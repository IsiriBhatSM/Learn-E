// lib/main.dart
import 'package:flutter/material.dart';
import 'home_page/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Facts App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(userName: 'User'), // replace 'User' with actual name when available
      // routes: { '/profile': (_) => ProfilePage(), ... }
    );
  }
}
