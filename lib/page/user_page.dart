import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserPage extends StatefulWidget {
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String query = "";

  TextEditingController queryTextEditingController =
      new TextEditingController();
  dynamic data;

  bool notVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users => ${query}"),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: queryTextEditingController,
                    obscureText: notVisible,
                    decoration: InputDecoration(
                        labelText: "username github",
                        fillColor: Colors.green,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              notVisible = !notVisible;
                            });
                          },
                          icon: Icon(!notVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          color: Colors.green,
                        ),
                        contentPadding: const EdgeInsets.only(left: 20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                                width: 1, color: Colors.green))),
                  ),
                )),
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    setState(() {
                      this.query = queryTextEditingController.text;
                      _search(query);
                    });
                  },
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: (data == null) ? 0 : data["items"].length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    data['items'][index]['avatar_url']),
                                radius: 35,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text("${data['items'][index]['login']}"),
                            ],
                          ),
                          CircleAvatar(
                            child: Text("${data['items'][index]['score']}"),
                          )
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  void _search(String query) {
    String url =
        "https://api.github.com/search/users?q=${query}&per_page=20&page=0";

    print(url);

    http.get(Uri.parse(url)).then((response) {
      setState(() {
        this.data = json.decode(response.body);
      });
    }).catchError((onError) {
      print(onError);
    });
  }
}
