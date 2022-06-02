import 'package:flutter/material.dart';
import 'package:maca/screens/main_screen.dart';
import 'package:maca/util/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      theme: Constants.lightTheme,
      // darkTheme: Constants.darkTheme,
      home: MainScreen(),
    );
  }
}
