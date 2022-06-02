import 'dart:convert';

import 'package:http/http.dart';

class ApiService {
  final String baseUrl = "https://newsapi.org/v2";
  final String apiKey = "ded2246c613e46d0983e3626890a0021";

  Client client = Client();

  Future<List> getCurrentBreaking() async {
    final response = await client
        .get(Uri.parse("$baseUrl/top-headlines?country=us&apiKey=$apiKey"));
    if (response.statusCode == 200) {
      return json.decode(response.body)['articles'];
    } else {
      throw Exception('Failed to load data');
    }
  }
}
