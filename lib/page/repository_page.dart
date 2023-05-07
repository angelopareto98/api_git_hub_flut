import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GitRepoPage extends StatefulWidget {
  String login;
  String avatarUrl;

  GitRepoPage({required this.login, required this.avatarUrl});

  @override
  State<GitRepoPage> createState() => _GitRepoPageState();
}

class _GitRepoPageState extends State<GitRepoPage> {
  dynamic dataRepo;

  @override
  void initState() {
    // super.initState();
    _loadRepository();
  }

  Future<void> _loadRepository() async {
    String url = "https://api.github.com/users/${widget.login}/repos";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        dataRepo = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Repository ${widget.login}"),
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.avatarUrl),
          )
        ],
      ),
      body: Center(
        child: ListView.separated(
            itemBuilder: (context, index) => ListTile(
                  title: Text("${dataRepo[index]['name']}"),
                ),
            separatorBuilder: (context, index) => const Divider(
                  height: 4,
                  color: Colors.green,
                ),
            itemCount: dataRepo == null ? 0 : dataRepo.length),
      ),
    );
  }
}
