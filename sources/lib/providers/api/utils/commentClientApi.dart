import 'dart:convert';

import 'package:AthletiX/providers/api/clientApi.dart';
import '../../../model/comment.dart';

class CommentClientApi{
  late final ClientApi _clientApi;
  final String _endpoint = 'comments';

  CommentClientApi(ClientApi cli){
    _clientApi = cli;
  }

  Future<Comment> createComment(Comment comment) async {
    String commentJson = commentToJson(comment);
    final responseJson = await _clientApi.postData(_endpoint, commentJson);
    return commentFromJson(responseJson);
  }

  Future<Comment> getCommentById(int commentId) async {
    return commentFromJson(await _clientApi.getDataById(_endpoint, commentId));
  }

  Future<List<Comment>> getComment() async {
    try {
      String commentsJsonString = await _clientApi.getData(_endpoint);
      List<dynamic> commentsJson = jsonDecode(commentsJsonString);
      return commentsJson.map((json) => Comment.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<Comment> updateComment(int commentId, Comment updatedComment) async {
    return commentFromJson(await _clientApi.putData('$_endpoint/$commentId', commentToJson(updatedComment)));
  }

  Future<Comment> deleteComment(int commentId) async {
    return commentFromJson(await _clientApi.deleteData('$_endpoint/$commentId'));
  }
}