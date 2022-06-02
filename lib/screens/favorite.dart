import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:maca/util/constants.dart';
import 'package:maca/util/shared_preferences.dart';
import 'package:maca/widgets/appBar.dart';
import 'package:maca/widgets/drawer.dart';
import 'package:maca/widgets/grid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const FavoriteScreen({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  SharedPref sharedPref = SharedPref();

  void initialization() async {
    // print(await sharedPref.read('favorite').runtimeType);
  }

  loadPreferences() async {
    String data = await sharedPref.read('favorite');
    if (data == null) {
      data = jsonEncode([]);
    }
    List<dynamic> dataList = jsonDecode(data);
    return dataList;
  }

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        key: RIKeys.rikeys1,
        resizeToAvoidBottomInset: false,
        appBar: BaseAppBar(
          title: const Text(""),
          leading: IconButton(
              onPressed: () => widget.scaffoldKey.currentState?.openDrawer(),
              icon: const Icon(FontAwesome5.bars)),
          appBar: AppBar(),
          color: Colors.white,
        ),
        drawer: DrawerWidget(
          scaffoldKey: widget.scaffoldKey,
        ),
        body: FutureBuilder(
            future: loadPreferences(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                        "Something went wrong: \n ${snapshot.error.toString()}"));
              }

              if (snapshot.connectionState == ConnectionState.done) {
                return Column(children: [gridWidget(snapshot.data)]);
                // return Container();
              }

              return const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
