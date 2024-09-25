import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/comment.dart';

class CommentsService {
  Future<List<Comment>> fetchCommentsData() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/comments');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Comment> comments = [];
        data.map((json) {
          comments.add(Comment.fromJson(json));
        }).toList();

        return comments;
      } else {
        log('Failed to fetch data. Status Code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      log('Error occurred: $error');
      return [];
    }
  }
}
