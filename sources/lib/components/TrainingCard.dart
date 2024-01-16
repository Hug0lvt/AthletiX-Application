import 'package:flutter/material.dart';

class TrainingCard extends StatelessWidget{
  //final Session session ;
   late Map<String,String> session;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      constraints: const BoxConstraints.expand(
        width: 10.0,
        height: 10.0,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0.0),
          topRight: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(0.0),
        ),
        color: const Color(0xFF1A1A1A).withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: const Color(0xF3B9EE).withOpacity(0.2),
            offset: const Offset(3, 3),
            blurRadius: 2.0,
            spreadRadius: 0,
            blurStyle: BlurStyle.normal,
          ),
          BoxShadow(
            color: const Color(0xA2E4E6).withOpacity(0.2),
            offset: const Offset(-3, -3),
            blurRadius: 2.0,
            spreadRadius: 0,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: const Row(
        children: [
          SizedBox(width: 20.0),
          Text(
            "1x",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          Text(
            "test",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

}