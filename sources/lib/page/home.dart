import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/commentCard.dart';
import '../model/comment.dart';
import '../providers/api/utils/commentsClientApi.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final commentClientApi = getIt<CommentsClientApi>();
  late VideoPlayerController _controller;
  int _currentVideoIndex = 0;
  List<String> _videoAssets = [
    "assets/doigby.mp4",
    "assets/airsoft.mp4",
    "assets/doigby.mp4",
  ];

  // TODO a brancher avec l'objet récup par api
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(_videoAssets[_currentVideoIndex])
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

  void onPressed() async {
    List<Comment> comments = await commentClientApi.getComments();
    showModalBottomSheet<int>(
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Colors.black87,
      context: context,
      builder: (context) {
        return Container(
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
                    return CommentCard();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _videoAssets.length,
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
  }

  void _updateVideoController() {
    _controller.pause();
    _controller = VideoPlayerController.asset(_videoAssets[_currentVideoIndex])
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.play();
        setState(() {});
      });
  }

  Widget _buildVideoPage(int index) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: onScreenTap,
            child: Container(
              color: const Color(0xFF363636),
              child: Center(
                child: _controller.value.isInitialized
                    ? FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: VideoPlayer(_controller),
                  ),
                )
                    : CircularProgressIndicator(),
              ),
            ),
          ),
        ),
        if (_currentVideoIndex != index)
          AnimatedOpacity(
            duration: Duration(milliseconds: 250),
            opacity: (_controller.value.position.inSeconds / _controller.value.duration.inSeconds).clamp(0.0, 1.0),
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
                      Container(
                        width: 50,
                        height: 50,
                        child: ClipOval(
                          child: Container(
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/EditIcon.svg',
                                width: 50,
                              ),
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
                        const Text(
                        '123',
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
                            '456',
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
                          const Text(
                            '789',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Description de la vidéo',
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
