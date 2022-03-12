import 'package:flutter/material.dart';
import 'package:life_app/LandingaPage/chats.dart';
import 'package:life_app/Models/friendsModel.dart';
import 'package:google_fonts/google_fonts.dart';

class Friends extends StatefulWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  List<FriendsModel> friends = [
    FriendsModel(
        name: 'Ramanujan',
        text: 'Hi!',
        date: 'today',
        imageURL:
            "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg",
        messageCount: 2,
        messageType: "sender",
        selectedIcons: "",
        reactionPanel: "all"),
        image: false,
        imageS3: null),
    FriendsModel(
        name: 'Ramanujan',
        text: 'Hello!',
        date: 'today',
        imageURL:
            "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg",
        messageCount: 2,
        messageType: "sender",
        image: false,
        imageS3: null
        selectedIcons: "",
        reactionPanel: "all"
        ),
    FriendsModel(
        name: 'Ramanujan',
        text: 'Happy Birthday!',
        date: 'today',
        imageURL:
            "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg",
        messageCount: 2,
        messageType: "sender",
        image: false,
        imageS3: null,
        selectedIcons: "",
        reactionPanel: "all"),
    FriendsModel(
        name: 'Ramanujan',
        text: 'Thank you!',
        date: 'today',
        imageURL:
            "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg",
        messageCount: 2,
        messageType: "receiver",
        selectedIcons: "",
        reactionPanel: "all",
        image: false,
        imageS3: null),
    FriendsModel(
        name: 'Ramanujan',
        text: 'Glad you remembered.',
        date: 'today',
        imageURL:
            "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg",
        messageCount: 2,
        messageType: "receiver",
        selectedIcons: "",
        reactionPanel: "all",
        image: false,
        imageS3: null),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: friends.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => Chats(),
              //     ));

            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder:(context,animation,_) {
              //return Chats();
                return ChatsCopy();
              },opaque: false));
            },
            child: Container(
              padding:
                  EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(friends[index].imageURL),
                          maxRadius: 23,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  friends[index].name,
                                  style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          color: Colors.white, fontSize: 16)),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      friends[index].text +
                                          "  . " +
                                          friends[index].date,
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: Colors.white38,
                                              fontSize: 16)),
                                    ),
                                    Spacer(
                                      flex: 1,
                                    ),
                                    Container(
                                      height: 18,
                                      width: 18,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue.shade300),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 2),
                                        child: Text(
                                          friends[index]
                                              .messageCount
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                // Text(friends[index].time)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
// Route _createRoute() {
//   // return PageRouteBuilder(
//   //   pageBuilder: (context, animation, secondaryAnimation) => const  Chats(),
//   //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
//   //     const begin = Offset(0.0, 1.0);
//   //     const end = Offset.zero;
//   //     const curve = Curves.ease;

//   //     var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//   //     return SlideTransition(
//   //       position: animation.drive(tween),
//   //       child: child,
//   //     );
//   //   },
//   // );

  
