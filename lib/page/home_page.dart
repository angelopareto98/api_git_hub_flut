import 'package:api_git_hub_flut/page/user_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../animation/global_animation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
        child: Column(
          children: [
            const DelayedAnimation(
                delay: 2500,
                child: Text(
                  "ZANAK'I ABA",
                  style: TextStyle(color: Colors.green, fontSize: 10),
                )),
            DelayedAnimation(
                delay: 1500,
                child: SizedBox(
                  height: 370,
                  child: Image.asset('image/logo_git.png'),
                )),
            DelayedAnimation(
                delay: 2500,
                child: Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 20),
                  child: Text(
                    "This is a small application using api github to search all user in git, and listing all repo public of this user searched",
                    textAlign: TextAlign.center,
                    style:
                        GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
                  ),
                )),
            DelayedAnimation(
                delay: 3500,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.all(13)),
                    child: const Text("GET STARTED"),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UserPage()));
                    },
                  ),
                )),
          ],
        ),
      )),
    );
  }
}
