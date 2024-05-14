import 'dart:convert';

import 'package:AthletiX/providers/api/clientApi.dart';
import '../../../model/comment.dart';

class CommentsClientApi{
  late final ClientApi _clientApi;
  final String _endpoint = 'comments';

  CommentsClientApi(ClientApi cli){
    _clientApi = cli;
  }

  Future<Comment> getCommentsById(int commentId) async {
    return commentFromJson(await _clientApi.getDataById(_endpoint, commentId));
  }

  Future<List<Comment>> getComments() async {
    String commentsJsonString = await _clientApi.getData(_endpoint);
    List<dynamic> commentsJson = jsonDecode(commentsJsonString);
    return commentsJson.map((json) => commentFromJson(json)).toList();
  }
}