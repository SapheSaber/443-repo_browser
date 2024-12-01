import 'package:flutter/material.dart';

class ShowRepo extends StatelessWidget {
  final String htmlURL;

  ShowRepo(this.htmlURL);

  @override
  Widget build(BuildContext context) {
    print("Show Repo Details");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Repository Details"),
      ),
    );
  }
}
