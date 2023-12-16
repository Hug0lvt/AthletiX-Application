import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                      color: Colors.grey.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(1000)
                    ),
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
                        const Row(
                          children: [
                            Icon(Icons.favorite, color: Colors.white),
                            SizedBox(width: 5.0),
                            Text('123', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        const Row(
                          children: [
                            Icon(Icons.comment, color: Colors.white),
                            SizedBox(width: 5.0),
                            Text('456', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        const Row(
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
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
