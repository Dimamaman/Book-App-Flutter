import 'dart:async';

import 'package:book_app_flutter/main/main_screen.dart';
import 'package:book_app_flutter/onboarding/onboarding_screen.dart';
import 'package:book_app_flutter/pref/my_shared_pref.dart';
import 'package:book_app_flutter/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pref/book_pref.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  bool? isFirst;
  BookPRef sharedPreferencesManager = BookPRef();
  final pref = MySharedPref();

  Future<void> next() async {
    await Future.delayed(const Duration(milliseconds: 2000));
  }
  Future<void> load() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    isFirst = pref.getBool('isOpened')!;
  }

  @override
  void initState() {
    print("initga kirdi");
    // load();
    // next().then((value) {
    //   Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => isFirst==null||isFirst == true ? Splash_Screen() : Main_Screen()));
    // });

    if(sharedPreferencesManager.getBool()) {
      print("ifge kirdi");
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => OnBoarding_Screen()));
    } else {
      print("else kirdi");
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => Main_Screen()));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 250,
            width: 250,
            child: Image.asset('assets/images/splash.png')
        ),
      ),
    );
  }
}
