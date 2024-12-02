import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowRepo extends StatelessWidget {
  final String htmlURL;

  ShowRepo(this.htmlURL);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Repository Details"),
      ),
      body: Container(
        width: double.infinity,
        child: WebView(
          initialUrl: htmlURL,
          javascriptMode: JavascriptMode.unrestricted, // Enable JavaScript
        ),
      ),
    );
  }
}
