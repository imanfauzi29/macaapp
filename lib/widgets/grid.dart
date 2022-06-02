import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:maca/screens/detail.dart';
import 'package:maca/widgets/card.dart';

Widget gridWidget(List data) {
  return Expanded(
      child: MasonryGridView.count(
          itemCount: data.length,
          crossAxisCount: 2,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemBuilder: (BuildContext ctx, index) {
            return InkWell(
              onTap: () => showModalBottomSheet(
                  context: ctx,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                  builder: (context) => Container(
                      padding: const EdgeInsets.all(20),
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: DetailScreen(
                        data: data,
                        index: index,
                      ))),
              child: CardWidget(data: data, index: index),
            );
          }));
}
