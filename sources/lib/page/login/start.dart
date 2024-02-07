import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: SvgPicture.asset('assets/AthletiX.svg', width: width*0.8),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset('assets/LetsGo.svg', width: width*0.8,),
                  Icon(
                    Icons.arrow_upward,
                    size: width*0.1,
                    color: Colors.white,
                  ),
                  SizedBox(height: width*0.2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
