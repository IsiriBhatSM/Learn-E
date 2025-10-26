import 'package:flutter/material.dart';

class ProgramDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final program = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(title: Text(program['title'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(program['description']),
      ),
    );
  }
}
