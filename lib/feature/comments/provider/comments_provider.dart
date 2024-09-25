import 'package:flutter/material.dart';
import 'package:round_1b/feature/comments/model/comment.dart';
import 'package:round_1b/feature/comments/service/comments_service.dart';

class CommentsProvider with ChangeNotifier {
  bool _maskEmail = false;
  bool get maskEmail => _maskEmail;

  void setMaskEmail(bool value){
    _maskEmail = value;
    notifyListeners();
  }



  Future<List<Comment>> fetchComments() async {
    CommentsService service = CommentsService();
    return await service.fetchCommentsData();
  }
}
