import 'package:api_git_hub_flut/page/home_page.dart';
import 'package:api_git_hub_flut/page/user_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      routes: {
        "/": (context) => const HomePage(),
        "/users": (context) => UserPage()
      },
      initialRoute: "/",
    );
  }
}
