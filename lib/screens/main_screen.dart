import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maca/screens/favorite.dart';
import 'package:maca/screens/home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> _pages() {
    return [
      HomeScreen(scaffoldKey: _scaffoldKey),
      FavoriteScreen(
        scaffoldKey: _scaffoldKey,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Scaffold(
                      body: IndexedStack(children: _pages()),
                    ))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: const Image(
          image: AssetImage("assets/maca-logo-text.png"),
        ));
  }
}
