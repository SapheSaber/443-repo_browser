import 'package:flutter/material.dart';
import 'package:repo_browser/utils/strings.dart' as strings;
import 'package:repo_browser/views/list_repos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      title: strings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: g(),
     
    );
  }
}
class ListRepos extends StatelessWidget {
  const ListRepos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Repositories"), // Adds a title to the app bar
        
      ),
      body: Center(
        child: Text(
          "No Repositories Found",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }
}