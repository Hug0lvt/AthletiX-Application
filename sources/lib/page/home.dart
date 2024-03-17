import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/commentCard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/doigby.mp4")
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

              // ------------------------ Partie Commentaire ----------------------------

          /*Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.90,
              decoration: BoxDecoration(
                color: const Color(0xFF202020).withOpacity(0.9),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width * 0.50,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: [
                        CommentCard(),
                        CommentCard(),
                        CommentCard(),
                        CommentCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),*/
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