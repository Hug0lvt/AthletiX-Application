import 'package:AthletiX/providers/api/clientApi.dart';
import '../../../model/post.dart';

class PostClientApi{
  late final ClientApi _clientApi;
  final String _endpoint = 'posts';

  PostClientApi(ClientApi cli){
    _clientApi = cli;
  }

  Future<Post> createPost(Post post) async {
    return postFromJson(await _clientApi.postData(_endpoint, postToJson(post)));
  }

  Future<Post> getPostById(int postId) async {
    return postFromJson(await _clientApi.getDataById(_endpoint, postId));
  }

  // TODO LIST BY CATEGORY
  Future<Post> getPostByCategory(String categoryId) async {
    return postFromJson(await _clientApi.getData('$_endpoint/category/$categoryId'));
  }

  // TODO LIST BY USER
  Future<Post> getPostByUser(String profileId) async {
    return postFromJson(await _clientApi.getData('$_endpoint/user/$profileId'));
  }

  Future<Post> updatePost(int postId, Post updatedPost) async {
    return postFromJson(await _clientApi.putData('$_endpoint/$postId', postToJson(updatedPost)));
  }

  Future<Post> deletePost(int postId) async {
    return postFromJson(await _clientApi.deleteData('$_endpoint/$postId'));
  }
}