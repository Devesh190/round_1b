import 'package:flutter/material.dart';
import 'package:round_1b/feature/comments/model/comment.dart';
import 'package:round_1b/feature/comments/service/comments_service.dart';

class CommentsProvider with ChangeNotifier {
  Future<List<Comment>> fetchComments() async {
    CommentsService service = CommentsService();
    return await service.fetchCommentsData();
  }
}
