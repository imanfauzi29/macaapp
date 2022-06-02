import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:maca/api/api_service.dart';
import 'package:maca/widgets/appBar.dart';
import 'package:maca/widgets/drawer.dart';
import 'package:maca/widgets/grid.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

onPressedSearch() {
  print('Search');
}

onChangeLayout() {
  print('Change Layout');
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  String _searchText = "";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _searchQuery = TextEditingController();

  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        key: _scaffoldKey,
        appBar: BaseAppBar(
            title: _isSearching ? _buildSearchField() : const Text(""),
            leading: _isSearching
                ? const BackButton()
                : IconButton(
                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                    icon: const Icon(FontAwesome5.bars)),
            appBar: AppBar(),
            actions: _buildActions()),
        drawer: const DrawerWidget(),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text("Discover",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text("Membaca merupakan jendela dunia",
                      style: TextStyle(fontSize: 16, color: Colors.black45)),
                  IconButton(
                    onPressed: () => onChangeLayout(),
                    icon: const Icon(WebSymbols.th),
                    iconSize: 14.0,
                  )
                ],
              ),
              FutureBuilder(
                  future: apiService.getCurrentBreaking(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                          child: Text(
                              "Something went wrong: \n ${snapshot.error.toString()}"));
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      List data = snapshot.data;
                      return gridWidget(data);
                    }

                    return const Center(child: CircularProgressIndicator());
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: "Search Data...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQuery.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      _searchText = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQuery.clear();
      updateSearchQuery("");
    });
  }
}
