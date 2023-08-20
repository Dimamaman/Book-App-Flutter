import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  bool? isFirst;

  Future<void> next() async {
    await Future.delayed(const Duration(milliseconds: 2000));
  }
  Future<void> load() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    isFirst = pref.getBool('isFirst') ?? true;
  }

  @override
  void initState() {
    load();
    next().then((value) {
      isFirst == true ? Get.offNamed('/onboard') : Get.offNamed('/home');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
            child: Image.asset('assets/images/splash.png')
        ),
      ),
    );
  }
}
