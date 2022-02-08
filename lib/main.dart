import 'dart:io';

import 'package:expanse_manager/app/helpers.dart/Globals.dart';
import 'package:expanse_manager/app/models/User.dart';
import 'package:expanse_manager/app/themes/textTheme.dart';
import 'package:expanse_manager/views/screens/about.dart';
import 'package:expanse_manager/views/screens/category_page.dart';
import 'package:expanse_manager/views/screens/home_page.dart';
import 'package:expanse_manager/views/screens/splash_page.dart';
import 'package:expanse_manager/views/screens/todo.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/themes/appTheme.dart';

void main() async {
  await Hive.initFlutter(); //init hive
  Hive.registerAdapter(UserAdapter());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  ThemeMode? theme;
  @override
  void initState() {
    super.initState();
    Hive.openBox(hiveBox).then((value) {
      var themeString = value.get(themeKey);
      if (themeString != null) {
        setState(() {
          theme = themeString == 'dark' ? ThemeMode.dark : ThemeMode.light;
        });
      } else {
        setState(() {
          theme = ThemeMode.system;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // theme: AppTheme.lightTheme,
      // The Mandy red, light theme.
      theme: FlexThemeData.light(
        scheme: FlexScheme.rosewood,
        textTheme: myBaseTextTheme,
      ),
      // The Mandy red, dark theme.
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.rosewood,
        textTheme: myBaseTextTheme,
      ),
      // Use dark or light theme based on system setting.
      themeMode: theme != null ? theme! : ThemeMode.system,

      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
        AboutPage(),
      ],
      navBarStyle: NavBarStyle.style3,
      backgroundColor: Theme.of(context).colorScheme.background,
      items: [
        _getTabItem(const Icon(Icons.home_rounded), "Home"),
        _getTabItem(const Icon(Icons.checklist), "Todo"),
        _getTabItem(const Icon(Icons.category_rounded), "Categories"),
        _getTabItem(const Icon(Icons.person), "Profile"),
      ],
    );
  }

  PersistentBottomNavBarItem _getTabItem(Icon icon, String title) {
    return PersistentBottomNavBarItem(
      icon: icon,
      title: title,
      activeColorPrimary: Theme.of(context).colorScheme.primary,
      activeColorSecondary: Theme.of(context).colorScheme.secondary,
    );
  }
}
