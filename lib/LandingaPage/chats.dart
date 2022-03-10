import 'package:flutter/material.dart';
import 'package:life_app/LandingaPage/sentMessage.dart';

import 'package:life_app/LandingaPage/receivedMessage.dart';
class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(builder: (context, constraints) {
//------------------------------------------------Circle Animation--------------------------
        return Container(
          child: TweenAnimationBuilder(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 1300),
            child: ChatsPage(),
            builder: (context, value, child) {
              return ShaderMask(
                blendMode: BlendMode.modulate,
                shaderCallback: (rect) {
                  return RadialGradient(
                          radius:
                              (value != null ? (value as double) * 5 : 5.00),
                          colors: [
                            Colors.white,
                            Colors.white,
                            Colors.transparent,
                            Colors.transparent
                          ],

                          stops: [1.0, 0.65, 0.5, 0.0],
                          center: FractionalOffset(0.0, 0.65))
                      .createShader(rect);
                },
                child: child,
              );
            },
          ),
        );
      }
          //------------------------------
          ),
    );
  }
}

class ChatsPage extends StatefulWidget {
  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        automaticallyImplyLeading: false,
        shadowColor: Colors.yellow[100],
        backgroundColor: Colors.grey[800],
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.yellow[100],
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg"),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Name   >",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[850],
                  ),
                  child: Icon(
                    Icons.headphones_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        height: 700,
        decoration: BoxDecoration(
          color: Colors.grey[800],
        ),
        child: Stack(children: <Widget>[
  
Padding(
            padding: const EdgeInsets.only(bottom:40,top:40,left: 10,right:10),
            child: ListView(
              children: const [
               InBubble(message: 'Hello'),
                OutBubble(message: 'Hi there'),
                OutBubble(message: 'How is it going?'),
                InBubble(message: 'Everything is OK'),
                OutBubble(message: 'Goodbye'),
                InBubble(message: 'See you soon')
              ],
            ),
          ),
          
        

          //-------------------CLOSE ICON------------------------
          Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 30),
            child: Transform(
              transform: Matrix4.translationValues(190, 580, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white70,
                        width: 2.0,
                      ),
                      color: Colors.grey[800],
                      shape: BoxShape.circle),
                  child: Icon(
                  
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 15
                  ),
                ),
              ),
            ),
          ),
          //----------------------------------------------------------------
          Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 0),
              child: Transform(
                transform: Matrix4.translationValues(0, 620, 0),
                child: Container(
                  width: 400,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                  ),
                  child: Row(
                    children: <Widget>[
                      Transform(
                        transform: Matrix4.translationValues(0, -13, 0),
                        child: InkWell(
                          child: IconButton(
                            icon: Icon(
                              Icons.photo_camera,
                              color: Colors.grey[800],
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      Transform(
                        transform: Matrix4.translationValues(0, -13, 0),
                        child: InkWell(
                          child: IconButton(
                            icon: Icon(
                              Icons.keyboard_voice,
                              color: Colors.grey[800],
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      Expanded(
                        child: Transform(
                          transform: Matrix4.translationValues(0, -13, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(35.0),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 3),
                                )
                              ],
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey[350],
                                          hintText: "message",
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.emoji_emotions_sharp,
                                      color: Colors.grey),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))
        ]),
      ),
    );
      
 
}

  
  
}
