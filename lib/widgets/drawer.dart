import 'package:flutter/material.dart';
import 'package:maca/screens/favorite.dart';
import 'package:maca/screens/home.dart';

class DrawerWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const DrawerWidget({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          SizedBox(
            width: double.infinity,
            height: 64,
            child: DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Image(
                    image: AssetImage("assets/maca-logo-text.png"),
                    height: 200,
                    width: 200,
                  ),
                  IconButton(
                      onPressed: () =>
                          widget.scaffoldKey.currentState?.closeDrawer(),
                      icon: const Icon(Icons.close))
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.of(context).pop(true);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomeScreen(
                  scaffoldKey: widget.scaffoldKey,
                ),
              ));
            },
          ),
          ListTile(
            title: const Text('Favorite'),
            leading: const Icon(Icons.favorite),
            onTap: () {
              Navigator.of(context).pop(true);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FavoriteScreen(
                  scaffoldKey: widget.scaffoldKey,
                ),
              ));
            },
          ),
        ],
      ),
    );
  }
}
