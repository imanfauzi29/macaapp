import 'package:flutter/material.dart';
import 'package:maca/screens/favorite.dart';
import 'package:maca/screens/home.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                      onPressed: () => _scaffoldKey.currentState?.closeDrawer(),
                      icon: const Icon(Icons.close))
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            leading: const Icon(Icons.home),
            onTap: () {
              Scaffold.of(context).openEndDrawer();
              Navigator.of(context).pop(true);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          ListTile(
            title: const Text('Favorite'),
            leading: const Icon(Icons.favorite),
            onTap: () {
              Scaffold.of(context).openEndDrawer();
              Navigator.of(context).pop(true);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoriteScreen()));
            },
          ),
        ],
      ),
    );
  }
}
