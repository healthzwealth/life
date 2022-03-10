import 'package:flutter/material.dart';

//sent message
class EmojiBox extends StatelessWidget {



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
                bottomRight: Radius.circular(19)
              ),
            ),
        child:  IconButton(
          onPressed: null,
                            icon: Icon(
                              Icons.emoji_symbols,
                              color: Colors.grey[800],
                            ),
          ),
        ),
        )
      ],
    );
  }
}