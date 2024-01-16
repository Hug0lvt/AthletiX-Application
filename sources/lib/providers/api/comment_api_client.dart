import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../exceptions/not_found_exception.dart';
import '../../model/comment.dart';
import 'api_client.dart';

mixin CommentApiClient on ApiClient {

  Future<Comment> createComment(Comment comment) async {
    final response = await http.post(
      Uri.parse('$baseUrl/comments'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(comment.toJson()),
    );

    switch (response.statusCode) {
      case 201:
        return Comment.fromJson(json.decode(response.body));
      default:
        throw Exception('Failed to create comment');
    }
  }

  Future<List<Comment>> getAllComments() async {
    final response = await http.get(Uri.parse('$baseUrl/comments'));

    switch (response.statusCode) {
      case 200:
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Comment.fromJson(json)).toList();
      default:
        throw Exception('Failed to fetch comments');
    }
  }

  Future<Comment> getCommentById(int commentId) async {
    final response = await http.get(Uri.parse('$baseUrl/comments/$commentId'));

    switch (response.statusCode) {
      case 200:
        return Comment.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Comment not found');
      default:
        throw Exception('Failed to fetch comment');
    }
  }

  Future<Comment> updateComment(int commentId, Comment updatedComment) async {
    final response = await http.put(
      Uri.parse('$baseUrl/comments/$commentId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedComment.toJson()),
    );

    switch (response.statusCode) {
      case 200:
        return Comment.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Comment not found');
      default:
        throw Exception('Failed to update comment');
    }
  }

  Future<Comment> deleteComment(int commentId) async {
    final response = await http.delete(Uri.parse('$baseUrl/comments/$commentId'));

    switch (response.statusCode) {
      case 200:
        return Comment.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Comment not found');
      default:
        throw Exception('Failed to delete comment');
    }
  }
}
