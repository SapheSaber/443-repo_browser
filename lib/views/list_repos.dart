import 'package:flutter/material.dart';
import 'package:repo_browser/utils/strings.dart' as strings;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:repo_browser/models/repo.dart';
import 'package:repo_browser/utils/styles.dart' as styles;
import 'package:repo_browser/views/show_repo.dart';

class ListRepos extends StatefulWidget {
  const ListRepos({Key? key}) : super(key: key);

  @override
  _ListReposState createState() => _ListReposState();
}

class _ListReposState extends State<ListRepos> {
  final List<dynamic> _repos = [];


  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    const dataUrl =
        'https://api.github.com/search/repositories?q=language%3APython&sort=stars&order=desc';

    final response = await http.get(Uri.parse(dataUrl));

  

    if (response.statusCode == 200) {
    setState(() {
 
      final Map<String, dynamic> repoMap = json.decode(response.body);
      final List<dynamic> data = repoMap['items'];

      for (final item in data) {
        final name = item['name'] as String? ?? '';
        final url = item['html_url'] as String? ?? '';
        final description = item['description'] as String? ?? 'N/A';
        final repo = Repo(name, url, description);
        _repos.add(repo);
      }
      
  
    });
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  }

  Widget _buildRow(int i) {
  return Stack(children: <Widget>[

     Container(
        padding: const EdgeInsets.only(left: 10.0, right: 37.0, top: 5.0),
        child: TextButton(
          child: Text('${_repos[i].name}', style: styles.repoNameFont),
          onPressed: () {
            String htmlURL = _repos[i].url;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ShowRepo(htmlURL),
              ),
            );
          },
        ),
      ),

    Container(
      padding:
          EdgeInsets.only(left: 19.0, right: 37.0, top: 51.0, bottom: 5.0),
      child: Text('${_repos[i].description}', style: styles.descriptionFont),
    ),

  ]);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(strings.appTitle),
      ),

    body: ListView.separated(
        itemCount: _repos.length,
        itemBuilder: (BuildContext context, int position) {
          return _buildRow(position);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}