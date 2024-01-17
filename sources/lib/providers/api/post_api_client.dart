import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../exceptions/not_found_exception.dart';
import '../../model/post.dart';
import 'api_client.dart';

mixin PostApiClient on ApiClient {

  Future<Post> createPost(Post post) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(post.toJson()),
    );

    switch (response.statusCode) {
      case 201:
        return Post.fromJson(json.decode(response.body));
      default:
        throw Exception('Failed to create post');
    }
  }

  Future<Post> getPostById(int postId) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/$postId'));

    switch (response.statusCode) {
      case 200:
        return Post.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Post not found');
      default:
        throw Exception('Failed to fetch post');
    }
  }

  Future<List<Post>> getPostsByCategory(int categoryId, int index, int number) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/$categoryId/category?index=$index&number=$number'));

    switch (response.statusCode) {
      case 200:
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Post.fromJson(json)).toList();
      default:
        throw Exception('Failed to fetch posts by category');
    }
  }

  Future<Post> updatePost(int postId, Post updatedPost) async {
    final response = await http.put(
      Uri.parse('$baseUrl/posts/$postId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedPost.toJson()),
    );

    switch (response.statusCode) {
      case 200:
        return Post.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Post not found');
      default:
        throw Exception('Failed to update post');
    }
  }

  Future<Post> deletePost(int postId) async {
    final response = await http.delete(Uri.parse('$baseUrl/posts/$postId'));

    switch (response.statusCode) {
      case 200:
        return Post.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Post not found');
      default:
        throw Exception('Failed to delete post');
    }
  }
}
