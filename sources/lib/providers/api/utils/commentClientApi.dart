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
    return commentFromJson(await _clientApi.postData(_endpoint, commentToJson(comment)));
  }

  Future<Comment> getCommentById(int commentId) async {
    return commentFromJson(await _clientApi.getDataById(_endpoint, commentId));
  }

  // TODO LIST
  Future<List<Comment>> getComment() async {
    String commentsJsonString = await _clientApi.getData(_endpoint);
    List<dynamic> commentsJson = jsonDecode(commentsJsonString);
    return commentsJson.map((json) => commentFromJson(json)).toList();
  }

  Future<Comment> updateComment(int commentId, Comment updatedComment) async {
    return commentFromJson(await _clientApi.putData('$_endpoint/$commentId', commentToJson(updatedComment)));
  }

  Future<Comment> deleteComment(int commentId) async {
    return commentFromJson(await _clientApi.deleteData('$_endpoint/$commentId'));
  }
}