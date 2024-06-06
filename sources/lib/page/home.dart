import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:AthletiX/page/profilePublic.dart';
import 'package:AthletiX/providers/localstorage/secure/authManager.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/commentCard.dart';
import '../model/comment.dart';
import '../model/profile.dart';
import '../providers/api/utils/commentClientApi.dart';
import '../main.dart';
import '../model/post.dart';
import '../providers/api/utils/postClientApi.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Profile? _profile;
  final commentClientApi = getIt<CommentClientApi>();
  final postClientApi = getIt<PostClientApi>();
  late VideoPlayerController _controller;
  int _currentVideoIndex = 0;
  List<Post> _posts = [];
  Uint8List? _imageFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
    fetchVideos();
  }

  Future<void> _loadProfile() async {
    Profile? profile = await AuthManager.getProfile();
    setState(() {
      _profile = profile;
    });
  }

  Future<void> fetchVideos() async {
    try {
      List<Post> posts = await postClientApi.getRecommendedPosts('1');
      print(posts);
      setState(() {
        _posts = posts;
        if (_posts.isNotEmpty) {
          _initializeVideoController();
        }
      });
    } catch (e) {
      print('Failed to load videos: $e');
    }
  }

  Future<void> fetchMoreVideos() async {
    try {
      List<Post> morePosts = await postClientApi.getRecommendedPosts('1', offset: _posts.length);
      setState(() {
        _posts.addAll(morePosts);
      });
    } catch (e) {
      print('Failed to load more videos: $e');
    }
  }

  void _initializeVideoController() {
    _controller = VideoPlayerController.network(_posts[_currentVideoIndex].content)
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.play();
        setState(() {});
      });
  }

  void onScreenTap() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  void onPressedLiked() {
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  void onPressed() {
    List<Comment> comments = _posts[_currentVideoIndex].comments;
    TextEditingController commentController = TextEditingController();

    showModalBottomSheet<int>(
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Colors.black87,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.85,
            child: Column(
              children: [
                Expanded(
                  child: comments.isEmpty
                      ? Center(
                    child: Text(
                      'Pas de commentaire pour cette publication',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                      : ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      return CommentCard(
                        username: comments[index].publisher!.username!,
                        commentText: comments[index].content!,
                        profileImageUrl: comments[index].publisher!.picture!,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: commentController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Ajouter un commentaire...',
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.black54,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send, color: Colors.white),
                        onPressed: () async {
                          if (commentController.text.isNotEmpty) {
                            Comment newComment = Comment(
                              id: 0,
                              publishDate: DateTime.now().toUtc(),
                              publisher: _profile!,
                              content: commentController.text,
                              answers: [],
                              post: _posts[_currentVideoIndex],
                              parentCommentId: null,
                            );
                            // Appelez l'API pour envoyer le commentaire
                            Comment createdComment = await commentClientApi.createComment(newComment);
                            setState(() {
                              _posts[_currentVideoIndex].comments.add(createdComment);
                            });
                            commentController.clear();
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _posts.isEmpty
          ? Center(child: CircularProgressIndicator())
          : PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _posts.length,
        controller: PageController(initialPage: _currentVideoIndex),
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) {
          return _buildVideoPage(index);
        },
      ),
    );
  }

  void onPageChanged(int index) {
    setState(() {
      _currentVideoIndex = index;
    });
    _updateVideoController();

    // Si nous sommes dans les 2 dernières vidéos, charger plus de vidéos
    if (_posts.length - index <= 2) {
      fetchMoreVideos();
    }
  }

  void _updateVideoController() {
    _controller.pause();
    _controller = VideoPlayerController.network(_posts[_currentVideoIndex].content)
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.play();
        setState(() {});
      });
  }

  Widget _buildVideoPage(int index) {
    final post = _posts[index];

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: onScreenTap,
            child: Container(
              color: const Color(0xFF363636),
              child: Center(
                child: _controller.value.isInitialized
                    ? LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    double videoWidth = _controller.value.size.width;
                    double videoHeight = _controller.value.size.height;
                    double screenWidth = MediaQuery.of(context).size.width;
                    double screenHeight = MediaQuery.of(context).size.height;

                    if (videoWidth < screenWidth || videoHeight < screenHeight) {
                      double scaleFactor = (videoWidth / videoHeight) < (screenWidth / screenHeight)
                          ? screenWidth / videoWidth
                          : screenHeight / videoHeight;

                      videoWidth *= scaleFactor;
                      videoHeight *= scaleFactor;

                      return Container(
                        width: screenWidth,
                        height: screenHeight,
                        color: Colors.black,
                        child: Center(
                          child: SizedBox(
                            width: videoWidth,
                            height: videoHeight,
                            child: VideoPlayer(_controller),
                          ),
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: videoWidth,
                        height: videoHeight,
                        child: VideoPlayer(_controller),
                      );
                    }
                  },
                )
                    : CircularProgressIndicator(),
              ),

            ),
          ),
        ),
        if (_currentVideoIndex != index)
          AnimatedOpacity(
            duration: Duration(milliseconds: 250),
            opacity: (_controller.value.position.inSeconds /
                _controller.value.duration.inSeconds)
                .clamp(0.0, 1.0),
            child: VideoPlayer(_controller),
          ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width * 0.75,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF202020).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(1000),
                  ),
                  width: 60,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePublicPage(),
                            ),
                          );
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          child: ClipOval(
                            child: post.publisher.picture != null
                                ? Image.memory(
                              _imageFromBase64String(post.publisher.picture!)!,
                              fit: BoxFit.cover,
                            )
                                : SvgPicture.asset(
                              'assets/EditIcon.svg',
                              width: 50,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      GestureDetector(
                        onTap: onPressedLiked,
                        child: SvgPicture.asset(
                          'assets/LikeIcon.svg',
                          color: _isLiked ? null : Colors.white,
                          width: 45,
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        "0",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5.0),
                      Column(
                        children: [
                          SvgPicture.asset(
                            'assets/DoubleHaltereIcon.svg',
                            width: 45,
                          ),
                          const SizedBox(width: 10.0),
                          const Text(
                            '456', // Remplacer par la donnée appropriée si disponible
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              onPressed();
                            },
                            child: SvgPicture.asset(
                              'assets/CommentIcon.svg',
                              width: 35,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            post.comments.length.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  post.description,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
