import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:maca/util/util.dart';

class CardWidget extends StatelessWidget {
  final List data;
  final int index;

  const CardWidget({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: data[index]['urlToImage'] ?? 'assets/default-image.png',
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) =>
                const Image(image: AssetImage('assets/default-image.png')),
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
          Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: <Widget>[
                  Text(
                    "${data[index]['title']}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        Util.timeAgo(data[index]['publishedAt']),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: 50.0,
                            child: Text(
                              "By ${data[index]['author']}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                          ),
                          SizedBox(
                            width: 50.0,
                            child: Text(
                              "${data[index]['source']['name']}",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}
