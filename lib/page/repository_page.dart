import 'package:flutter/material.dart';

class GitRepoPage extends StatelessWidget {
  String login;

  GitRepoPage({required this.login});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Repository ${login}"),
      ),
      body: Center(
        child: Text("Repository ${login}"),
      ),
    );
  }
}
