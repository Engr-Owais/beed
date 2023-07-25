import 'package:flutter/material.dart';
import 'package:flutter_test_beed/src/pages/home_page.dart';
import 'package:flutter_test_beed/src/pages/landing_page.dart';
import 'package:get/get.dart';
import 'pages/login_page.dart';
import 'pages/registeration_page.dart';

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      initialRoute: isLoggedIn ? '/landingPage' : '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/signup', page: () => SignupPage()),
        GetPage(name: '/landingPage', page: () => LandingPage()),
        GetPage(name: '/homescreen', page: () => HomePage()),
      ],
    );
  }
}
