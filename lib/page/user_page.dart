import 'dart:convert';

import 'package:api_git_hub_flut/page/repository_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserPage extends StatefulWidget {
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String query = "";

  TextEditingController queryTextEditingController = TextEditingController();
  dynamic data;

  bool notVisible = false;

  int currentPage = 0;
  int totalPage = 0;
  int pageSize = 20;

  List<dynamic> itemsList = [];

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          if (currentPage < totalPage - 1) {
            currentPage++;

            _search(query);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users => ${query} => ${currentPage}/${totalPage}"),
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
                      itemsList = [];
                      currentPage = 0;
                      query = queryTextEditingController.text;
                      _search(query);
                    });
                  },
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: itemsList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GitRepoPage(
                                    login: itemsList[index]['login'])));
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    itemsList[index]['avatar_url']),
                                radius: 35,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text("${itemsList[index]['login']}"),
                            ],
                          ),
                          CircleAvatar(
                            child: Text("${itemsList[index]['score']}"),
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
        "https://api.github.com/search/users?q=${query}&per_page=${pageSize}&page=${currentPage}";

    http.get(Uri.parse(url)).then((response) {
      setState(() {
        data = json.decode(response.body);

        itemsList.addAll(data['items']);

        if (data['total_count'] % pageSize == 0) {
          totalPage = data['total_count'] ~/ pageSize;
        } else {
          totalPage = (data['total_count'] / pageSize).floor() + 1;
        }
      });
    }).catchError((onError) {
      print(onError);
    });
  }
}
