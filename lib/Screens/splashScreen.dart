import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thaimeet/Screens/homescreen.dart';
import 'package:thaimeet/Screens/inappscreens/mainscreen.dart';
import 'package:thaimeet/authentication/register.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    isuserLoggedIn();
    super.initState();
  }

  isuserLoggedIn() async {
    SharedPreferences sharedpreference = await SharedPreferences.getInstance();
    final bool? repeat = sharedpreference.getBool('islogin');
    print("Shared value got  ${repeat}");
    Future.delayed(
        const Duration(seconds: 3),
        () => {
              if (repeat == true)
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen())),
                }
              else
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()))
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("A trip to thailand"),
          Image.asset("assets/image.png", width: 30, height: 30)
        ],
      ),
      body: Container(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("assets/splashimage.png", width: 350, height: 350),
            const Text(
              "Thaimeet \n     2022",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      )),
    );
  }
}
