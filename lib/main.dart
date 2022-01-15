import 'dart:io';

import 'package:expanse_manager/app/helpers.dart/Globals.dart';
import 'package:expanse_manager/views/screens/about.dart';
import 'package:expanse_manager/views/screens/category_page.dart';
import 'package:expanse_manager/views/screens/home_page.dart';
import 'package:expanse_manager/views/screens/report_page.dart';
import 'package:expanse_manager/views/screens/signin_page.dart';
import 'package:expanse_manager/views/screens/splash_page.dart';
import 'package:expanse_manager/views/screens/todo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter(); //init hive
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  LandingPage({Key? key, this.currentIndex = 0}) : super(key: key);
  int currentIndex;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: [
        HomePage(),
        TodoPage(),
        CategoryPage(),
        ReportPage(),
        AboutPage(),
      ],
      items: [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home_rounded),
          title: "Home",
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.checklist),
          title: "Todo",
        ),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.category_rounded), title: "Categories"),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.print), title: "Report"),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.info_outline_rounded), title: "About"),
      ],
    );
  }
}
