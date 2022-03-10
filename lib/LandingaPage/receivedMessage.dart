import 'package:flutter/material.dart';
import 'package:life_app/LandingaPage/chatBubble.dart';
import 'dart:math' as math;
import 'package:flutter_slidable/flutter_slidable.dart';


//Received message bubble
class InBubble extends StatefulWidget {
  
 
  @override
  _InBubbleState createState() => _InBubbleState();
   
final String message;
  const InBubble({Key? key, required this.message}) : super(key: key);

}

class _InBubbleState extends State<InBubble> {

     void toggleSelection() {
      setState(() {
        //if (isSelected == false) {
        isSelected = true;
        //}
      // ReactionEmojiBox();
        //Navigator.of(context).pushNamed(ReactionEmojiBox.routeName);
        //} 
      });
  }
String message = 'Hi How are you?';
bool isSelected = false;
  @override
  Widget build(BuildContext context) {

    return Slidable(
    
      key: const ValueKey(0),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {}),
        children: const [
   

          SlidableAction(
            onPressed: null,
            backgroundColor: Color(0x384c74),
            foregroundColor: Colors.grey,
            icon: Icons.reply,
          ),
          SlidableAction(
            onPressed: null,
            backgroundColor: Color(0x384c74),
            foregroundColor: Colors.grey,
            icon: Icons.face,
          ),
        ],
      ),

      child: Stack(
        //mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            // child: CustomPaint(
            //   painter: Triangle(Colors.grey.shade600),
            //),
          ),
     
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade600,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(19),
                          topRight: Radius.circular(19),
                          bottomRight: Radius.circular(19),
                        ),
                      ),
                      child: Text(
                        message,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
            
                                                         
                  
            
        ],
      ),

    );
  }

}
