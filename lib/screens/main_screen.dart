import 'package:flutter/material.dart';
import 'package:maca/screens/favorite.dart';
import 'package:maca/screens/home.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Map<String, dynamic>> icons = [
    {'icon': Icons.home, 'title': 'Home', 'page': 0},
    {'icon': Icons.receipt, 'title': 'Add', 'page': 1},
    {'icon': Icons.favorite, 'title': 'Favorite', 'page': 2},
    {'icon': Icons.person, 'title': 'Profile', 'page': 3}
  ];

  List<Widget> _pages() {
    return [
      HomeScreen(),
      FavoriteScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(children: _pages()),
    );
  }
}
