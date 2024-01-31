import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child : Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/AthletiX.svg', width: width*0.8),
              SvgPicture.asset('assets/LetsGo.svg', width: width*1.5),
              SizedBox(height: 20),
              Icon(
                Icons.arrow_upward,
                size: 40,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}