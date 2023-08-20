import 'dart:async';

import 'package:book_app_flutter/main/main_screen.dart';
import 'package:book_app_flutter/onboarding/onboarding_screen.dart';
import 'package:book_app_flutter/pref/my_shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pref/book_pref.dart';

class Splash_Screen extends StatefulWidget {
  bool isFirst = false;

  Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  final pref = MySharedPref();

  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  void navigateToNextScreen() {
    Future.delayed(const Duration(milliseconds: 1500), () async {
      var isFirst = await pref.getBool();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          if (isFirst) {
            print("ifge kirdi");
            return OnBoarding_Screen();
          } else
            print("elsde kirdi");
            return Main_Screen();
        }), // Replace 'IntroPage()' with the actual instantiation of your Intro page
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/splash_image.png"),
            const SizedBox(height: 20.0),
            const Text(
              'INFINITY',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF223263),
                fontSize: 40,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w800,
                letterSpacing: 1.20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
