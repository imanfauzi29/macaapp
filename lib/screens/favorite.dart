import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:maca/util/shared_preferences.dart';
import 'package:maca/widgets/appBar.dart';
import 'package:maca/widgets/drawer.dart';
import 'package:maca/widgets/grid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  SharedPref sharedPref = SharedPref();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void initialization() async {
    // print(await sharedPref.read('favorite').runtimeType);
  }

  loadPreferences() async {
    String data = await sharedPref.read('favorite');
    return data;
  }

  @override
  void initState() {
    super.initState();
    // loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
          key: _scaffoldKey,
          appBar: BaseAppBar(
            title: const Text(""),
            leading: IconButton(
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                icon: const Icon(FontAwesome5.bars)),
            appBar: AppBar(),
            color: Colors.white,
          ),
          drawer: const DrawerWidget(),
          body: FutureBuilder(
              future: loadPreferences(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                          "Something went wrong: \n ${snapshot.error.toString()}"));
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  List data = jsonDecode(snapshot.data);
                  return gridWidget(data);
                }

                return const Center(child: CircularProgressIndicator());
              })),
    );
  }
}
