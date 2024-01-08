import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.12,
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        color: const Color(0xFF363636).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(1000)),
                    child: Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            '../assets/EditIcon.png',
                            width: 40.0,
                            height: 40.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Column(
                          children: [
                            Icon(Icons.favorite, color: Colors.white),
                            SizedBox(width: 5.0),
                            Text('123', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        const Column(
                          children: [
                            Icon(Icons.comment, color: Colors.white),
                            SizedBox(width: 5.0),
                            Text('456', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        const Column(
                          children: [
                            Icon(Icons.send, color: Colors.white),
                            SizedBox(width: 5.0),
                            Text('789', style: TextStyle(color: Colors.white)),
                          ],
                        ),
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

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
