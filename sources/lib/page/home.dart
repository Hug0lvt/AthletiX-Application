import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("../assets/doigby.mp4")
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
    _controller.pause();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                        width: MediaQuery.of(context).size.width * 0.11,
                        child: Column(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                '../assets/EditIcon.png',
                                width: 50.0,
                                height: 50.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Column(
                              children: [
                                SvgPicture.asset('assets/LikeIcon.svg', color: Colors.white, width: 45,),
                                const SizedBox(width: 5.0),
                                const Text('123', style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            const SizedBox(height: 5.0),
                            Column(
                              children: [
                                SvgPicture.asset('assets/DoubleHaltereIcon.svg', width: 45,),
                                const SizedBox(width: 10.0),
                                const Text('456', style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            const SizedBox(height: 5.0),
                            Column(
                              children: [
                                SvgPicture.asset('assets/CommentIcon.svg', width: 35,),
                                const SizedBox(width: 10.0),
                                const Text('789', style: TextStyle(color: Colors.white)),
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
        ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}