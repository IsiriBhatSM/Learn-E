import 'dart:convert';
import 'package:flutter/material.dart';

class ProgramListingScreen extends StatefulWidget {
  @override
  _ProgramListingScreenState createState() => _ProgramListingScreenState();
}

class _ProgramListingScreenState extends State<ProgramListingScreen> {
  late Future<List<dynamic>> programs;

  Future<List<dynamic>> loadPrograms() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/programs.json');
    return jsonDecode(jsonString);
  }

  @override
  void initState() {
    super.initState();
    programs = loadPrograms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Program Listing')),
      body: FutureBuilder<List<dynamic>>(
        future: programs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading programs'));
          } else {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final program = data[index];
                return ListTile(
                  title: Text(program['title']),
                  subtitle: Text(program['duration']),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/details',
                      arguments: program,
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
