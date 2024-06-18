import 'dart:convert';
import 'dart:io';
import 'package:AthletiX/model/profile.dart';
import 'package:AthletiX/providers/api/clientApi.dart';
import '../../../model/post.dart';

class PostClientApi {
  late final ClientApi _clientApi;
  final String _endpoint = 'posts';

  PostClientApi(ClientApi cli) {
    _clientApi = cli;
  }

  Future<Post> createPost(Post post) async {
    return postFromJson(await _clientApi.postData(_endpoint, postToJson(post)));
  }

  Future<Post> getPostById(int postId) async {
    return postFromJson(await _clientApi.getDataById(_endpoint, postId));
  }

  Future<List<Post>> getPostsByUser(String profileId, {int offset = 0, int limit = 30}) async {
    final response = await _clientApi.getData('$_endpoint/user/$profileId?offset=$offset&limit=$limit');
    final data = json.decode(response) as Map<String, dynamic>;
    return (data['items'] as List).map((item) => Post.fromJson(item)).toList();
  }

  Future<List<Post>> getRecommendedPosts(String profileId, {int offset = 0, int pageSize = 30}) async {
    final response = await _clientApi.getData('$_endpoint/recommendations/user/$profileId?offset=$offset&pageSize=$pageSize');
    final data = json.decode(response) as Map<String, dynamic>;
    return (data['items'] as List).map((item) => Post.fromJson(item)).toList();
  }

  Future<Post> updatePost(int postId, Post updatedPost) async {
    return postFromJson(await _clientApi.putData('$_endpoint/$postId', postToJson(updatedPost)));
  }

  Future<Post> deletePost(int postId) async {
    return postFromJson(await _clientApi.deleteData('$_endpoint/$postId'));
  }

  Future<void> uploadPostMedia(int postId, File mediaFile) async {
    final String url = '$_endpoint/$postId/upload';
    await _clientApi.postMultipartData(url, mediaFile);
  }

  Future<void> addExerciseToPost(int postId, int exerciseId) async {
    final String url = '$_endpoint/$postId/addExercise/$exerciseId';
    await _clientApi.postData(url, '');
  }

  Future<void> likePost(int postId, int profileId) async {
    final String url = '$_endpoint/$postId/likedby/$profileId';
    await _clientApi.postData(url, '');
  }

  Future<void> unlikePost(int postId, int profileId) async {
    final String url = '$_endpoint/$postId/unlikedby/$profileId';
    await _clientApi.deleteData(url);
  }

  Future<List<Profile>> likesOfPost(int postId) async {
    final response = await _clientApi.getData('$_endpoint/$postId/likes');
    final data = json.decode(response) as Map<String, dynamic>;
    return (data['items'] as List).map((item) => Profile.fromJson(item)).toList();
  }

}
