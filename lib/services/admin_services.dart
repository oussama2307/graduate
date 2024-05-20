import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:memoire/constants/utils.dart';
import 'package:memoire/global_varibales.dart';
import 'package:memoire/providers/usename_provider.dart';
import 'package:provider/provider.dart';

class ApiService {
  static const String _baseUrl = urlhttp;

  static Future<List<dynamic>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/posts'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return jsonData is List ? jsonData.cast<Map<String, dynamic>>() : [];
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    }
  }

  static Future<List<dynamic>> fetchUserPosts(
      BuildContext context, int id) async {
    const String apiUrl = '$urlhttp/user_posts';
    final queryParameters = {'id': id.toString()};
    final uri = Uri.parse(apiUrl).replace(queryParameters: queryParameters);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> posts = jsonDecode(response.body);
      return posts;
    } else {
      throw Exception('Failed to fetch user posts');
    }
  }

  static Future<List<dynamic>> fetchFavo(
      BuildContext context, int userID) async {
    const String apiUrl = '$urlhttp/favorites';
    final queryParameters = {'userID': userID.toString()};
    final uri = Uri.parse(apiUrl).replace(queryParameters: queryParameters);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> favorites = jsonDecode(response.body);
      return favorites;
    } else {
      throw Exception('Failed to fetch favorite posts');
    }
  }

  static Future<void> deletePost(
      int postId, int userId, BuildContext context) async {
    final url = Uri.parse('$urlhttp/posts/$postId');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'userId': userId});

    try {
      final response = await http.delete(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final String message = responseBody["message"];
        Utils.showErrorSnackBar(context, message);
      } else if (response.statusCode == 404) {
        print(
            'Post not found or you do not have permission to delete this post');
      } else {
        print('Error deleting post: ${response.body}');
      }
    } catch (e) {
      print('Error deleting post: $e');
    }
  }
}
