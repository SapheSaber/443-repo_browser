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
  final List<Repo> _repos = [];
  bool _isLoading = true; // Add loading indicator state

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    const dataUrl =
        'https://api.github.com/search/repositories?q=language%3APython&sort=stars&order=desc';

    try {
      final response = await http.get(Uri.parse(dataUrl));

      if (response.statusCode == 200) {
        setState(() {
          final Map<String, dynamic> repoMap = json.decode(response.body);
          final List<dynamic> data = repoMap['items'];

          _repos.clear(); // Clear any old data
          for (final item in data) {
            final name = item['name'] as String? ?? '';
            final url = item['html_url'] as String? ?? '';
            final description = item['description'] as String? ?? 'N/A';
            final repo = Repo(name, url, description);
            _repos.add(repo);
          }
          _isLoading = false; // Stop loading once data is fetched
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildRow(int i) {
    return Stack(children: <Widget>[
      // Repo title (clickable)
      Container(
        padding: const EdgeInsets.only(left: 10.0, right: 37.0, top: 5.0),
        child: TextButton(
          child: Text('${_repos[i].name}', style: styles.repoNameFont),
          onPressed: () {
            String htmlURL = _repos[i].htmlURL; // Correct property name
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ShowRepo(htmlURL),
              ),
            );
          },
        ),
      ),

      // Repo description
      Container(
        padding: const EdgeInsets.only(
            left: 19.0, right: 37.0, top: 51.0, bottom: 5.0),
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Show spinner while loading
          : _repos.isEmpty
              ? const Center(
                  child: Text(
                    "No Repositories Found",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : ListView.separated(
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
