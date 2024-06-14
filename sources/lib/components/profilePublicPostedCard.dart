import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:typed_data';

class ProfilePublicPostedCard extends StatefulWidget {
  final String videoUrl;
  final String postName;
  //final String postDate;
  final String description;
  final double width;
  final double height;

  ProfilePublicPostedCard({
    required this.videoUrl,
    required this.postName,
    //required this.postDate,
    required this.description,
    required this.width,
    required this.height,
  });

  @override
  _ProfilePublicPostedCardState createState() => _ProfilePublicPostedCardState();
}

class _ProfilePublicPostedCardState extends State<ProfilePublicPostedCard> {
  Uint8List? _thumbnail;

  @override
  void initState() {
    super.initState();
    _generateThumbnail();
  }

  Future<void> _generateThumbnail() async {
    try {
      final thumbnail = await VideoThumbnail.thumbnailData(
        video: widget.videoUrl,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 100, // specify the height of the thumbnail, width is auto-scaled to keep aspect ratio
        quality: 75, // specify the quality of the thumbnail
      );
      setState(() {
        _thumbnail = thumbnail;
      });
    } catch (e) {
      print('Error generating thumbnail: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xe51a1a1a),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.postName,
                style: TextStyle(
                  fontSize: widget.width * 0.05,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: _thumbnail != null
                  ? Image.memory(
                _thumbnail!,
                width: double.infinity,
                height: widget.height * 0.8,
                fit: BoxFit.cover,
              )
                  : Image.network(
                'https://via.placeholder.com/800/3C383B/B66CFF?text=No+Thumbnail',
                width: double.infinity,
                height: widget.height * 0.8,
                fit: BoxFit.cover,
              ),
            ),
            /*Text(
              widget.postDate,
              style: TextStyle(
                fontSize: widget.width * 0.03,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),*/
            Text(
              widget.description,
              style: TextStyle(
                fontSize: widget.width * 0.03,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Text(
              "Read More",
              style: TextStyle(
                fontSize: widget.width * 0.03,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
