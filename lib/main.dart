// import 'package:flutter/material.dart';
// import 'pages/home_page.dart';
// import 'theme.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Learn-E',
//       theme: learnETheme,
//       home: const HomePage(),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learn-E',
      theme: learnETheme,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
