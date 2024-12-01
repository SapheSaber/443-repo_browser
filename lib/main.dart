import 'package:flutter/material.dart';
import 'package:repo_browser/views/list_repos.dart';
import 'package:repo_browser/utils/strings.dart' as strings;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: strings.appTitle,
      debugShowCheckedModeBanner: false, // Removes the debug banner
      theme: ThemeData(
        primarySwatch: Colors.green, // Changed color to green
      ),
      home: const ListRepos(), // Placeholder for the next part
    );
  }
}

class ListRepos extends StatelessWidget {
  const ListRepos({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(); // Placeholder
  }
}