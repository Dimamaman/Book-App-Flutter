import 'package:book_app_flutter/core/api/book_api.dart';
import 'package:book_app_flutter/main/main_provider.dart';
import 'package:book_app_flutter/main/main_screen.dart';
import 'package:book_app_flutter/onboarding/onboarding_screen.dart';
import 'package:book_app_flutter/splash/splash_page.dart';
import 'package:book_app_flutter/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: Splash(),
        getPages: [
          GetPage(
              name: "/main",
              page: () => ChangeNotifierProvider(
                  create: (context) => BookProvider(BookApi()),
                  builder: (context, _) => Main_Screen())),
          GetPage(
            name: '/onboard',
            page: () => const OnBoarding_Screen(),
          ),
        ]);
  }
}
