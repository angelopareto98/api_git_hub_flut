import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String query = "";

  TextEditingController queryTextEditingController =
      new TextEditingController();

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
                    });
                    print(query);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
