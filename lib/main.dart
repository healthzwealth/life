import 'package:flutter/material.dart';
import 'package:life_app/LandingaPage/landingPage.dart';
import 'package:life_app/LandingaPage/reactionEmojiBox.dart';
void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      home: HomePage(),
      
          routes: {
            ReactionEmojiBox.routeName: (context) => ReactionEmojiBox()
            }
       
        
        );
  }
}
