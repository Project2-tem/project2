import 'package:flutter/material.dart';
import 'package:project2implement/screens/blind_screen.dart';
import 'package:project2implement/screens/deaf_screen_options.dart';
import 'package:project2implement/screens/first_screen.dart';
import 'package:project2implement/screens/object_detection.dart';
import 'package:project2implement/screens/second_screen.dart';
import 'package:project2implement/screens/deaf_screen.dart';
import 'package:project2implement/screens/detection_tabs.dart';

void main() {
  runApp(MyApp());
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        navigatorObservers: [
          routeObserver
        ],
        routes: {
          '/': (context) => MyHomePage(),
          '/second': (context) => SecondScreen(),
          BlindScreen.routeName: (context) => BlindScreen(),
          // '/object': (context) => ObjectDetection(),
          DeafScreen.routeName: (context) => DeafScreen(),
          DeafScreenOptions.routeName: (context) => DeafScreenOptions(),
          DetectionTabs.routeName: (context) => DetectionTabs(),
        });
  }
}
