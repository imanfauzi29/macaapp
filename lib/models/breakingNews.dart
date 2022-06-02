import 'package:flutter/foundation.dart';

class News {
  void urlToImage;
  String title, description, url, publishedAt, content, author, source;

  News(
      {required this.title,
      required this.description,
      required this.url,
      required this.publishedAt,
      required this.content,
      required this.author,
      required this.source});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      publishedAt: json['publishedAt'] as String,
      content: json['content'] as String,
      author: json['author'] as String,
      source: json['source'],
    );
  }
}
