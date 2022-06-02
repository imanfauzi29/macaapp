import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:intl/intl.dart';
import 'package:maca/screens/webView.dart';
import 'package:maca/util/shared_preferences.dart';
import 'package:maca/widgets/appBar.dart';

class DetailScreen extends StatefulWidget {
  final List data;
  final int index;
  DetailScreen({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  SharedPref sharedPref = SharedPref();
  late List dataLoad = widget.data;

  loadSharedPreferences() async {
    try {
      List data = await sharedPref.read('favorite');
      setState(() {
        dataLoad = data;
      });
    } catch (e) {
      Container();
    }
  }

  saveSharedPreferences(data) async {
    try {
      List list = [];
      List sf = await sharedPref.read('favorite');
      bool isExist = sf.contains(data);

      if (isExist) {
        await sharedPref.remove(data);
        log("MASUK SINI");
      } else {
        list.addAll(data);
        await sharedPref.save('favorite', list);
        SnackBar(content: Text('Berhasil menambahkan ke favorit'));
      }
    } catch (e) {
      Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          title: Container(), leading: const BackButton(), appBar: AppBar()),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    widget.data[widget.index]['source']['name'],
                    style: const TextStyle(color: Colors.grey),
                  )),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(widget.data[widget.index]['title'],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "${DateFormat.yMMMd().format(DateTime.parse(widget.data[widget.index]['publishedAt']))} By ${widget.data[widget.index]['author'] ?? ""}",
                            style: const TextStyle(
                                fontSize: 12.0, color: Colors.grey)),
                        IconButton(
                          icon: const Icon(FontAwesome.bookmark_empty),
                          onPressed: () {
                            saveSharedPreferences(widget.data[widget.index]);
                          },
                        )
                      ])),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CachedNetworkImage(
                  imageUrl: widget.data[widget.index]['urlToImage'],
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Image(
                      image: AssetImage('assets/default-image.png')),
                  imageBuilder: (context, imageProvider) => Container(
                    width: double.infinity,
                    height: 300.0,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  widget.data[widget.index]['description'] ?? "",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Text(
                  widget.data[widget.index]['content'] ?? "",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 67, 152, 221)),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebViewPage(
                              url: widget.data[widget.index]['url']))),
                  child: const Text("Read More",
                      style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
