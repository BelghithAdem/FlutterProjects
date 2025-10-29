import 'dart:convert';
import 'package:http/http.dart' as http;
import 'post_model.dart';

class ApiService {
  static const String baseUrl = "https://jsonplaceholder.typicode.com";

  static Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
