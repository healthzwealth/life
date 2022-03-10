import 'package:flutter/material.dart';
import 'package:life_app/LandingaPage/chatBubble.dart';
//sent message
class OutBubble extends StatelessWidget {
  final String message;
  const OutBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(19),
                topRight: Radius.circular(19),
                bottomLeft: Radius.circular(19),
              ),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),
        //CustomPaint(painter: Triangle(Colors.grey.shade900)),
      ],
    );
  }
}