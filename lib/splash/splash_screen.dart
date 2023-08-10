import 'dart:async';

import 'package:book_app_flutter/main/main.dart';
import 'package:book_app_flutter/onboarding/onboarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash_Screen extends StatefulWidget {
  bool isFirst = false;

  Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  bool? isFirst;

  Future<void> next() async {
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  Future<void> load() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    isFirst = pref.getBool('isOpened')!;
  }

  @override
  void initState() {
    load();
    next().then((value) {
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
              builder: (context) => isFirst == null || isFirst == true
                  ? OnBoarding_Screen()
                  : const Main_Screen()));
    });
    super.initState();
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

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSubscribed = prefs.getBool('isOpened') ?? true;

    print("Barma? -> $isSubscribed");

    isFirst = isSubscribed;
    setState(() {});
  }
}
