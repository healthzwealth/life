import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:life_app/Models/friendsModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {

  bool isSelected = false;
  int indexSelected = 0;
  int indexPos = 0;
  List<FriendsModel> messages = [
    FriendsModel(
        name: 'Ramanujan',
        text: 'Hi!',
        date: 'today',
        imageURL:
            "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg",
        messageCount: 2,
        messageType: "sender"),
    FriendsModel(
        name: 'Ramanujan',
        text: 'Hello!',
        date: 'today',
        imageURL:
            "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg",
        messageCount: 2,
        messageType: "receiver"),
    FriendsModel(
        name: 'Ramanujan',
        text: 'Happy Birthday!',
        date: 'today',
        imageURL:
            "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg",
        messageCount: 2,
        messageType: "sender"),
    FriendsModel(
        name: 'Ramanujan',
        text: 'Thank you!',
        date: 'today',
        imageURL:
            "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg",
        messageCount: 2,
        messageType: "receiver"),
    FriendsModel(
        name: 'Ramanujan',
        text: 'Glad you remembered.',
        date: 'today',
        imageURL:
            "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg",
        messageCount: 2,
        messageType: "receiver"),
  ];

  

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
    void toggleSelectionClose() {
      setState(() {
        //if (isSelected == false) {
        isSelected = false;
        
        //}
      // ReactionEmojiBox();
        //Navigator.of(context).pushNamed(ReactionEmojiBox.routeName);
        //} 
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
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
                  maxRadius: 18,
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
                        "Name",
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
        decoration: BoxDecoration(
          color: Colors.grey[800],
        ),
        child: Column(children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return  Slidable(
                  key: const ValueKey(0),
                  closeOnScroll: true,
                  
                  startActionPane: ActionPane(
                    extentRatio: 1.6/6,
                    motion: const ScrollMotion(),
                  
                    children: const [
             
                      SlidableAction(
                          onPressed: null,
                          backgroundColor: Color(0x384c74),
                          foregroundColor: Colors.grey,
                          icon: Icons.reply_outlined,
                          spacing: 0,
                        ),
                    SlidableAction(
                          onPressed: null,
                          backgroundColor: Color(0x384c74),
                          foregroundColor: Colors.grey,
                          icon: Icons.face,
                         
                        ),

                          ],
                  ),
                    child:GestureDetector(
                      //onLongPress: toggleSelection,
                      onTap: toggleSelectionClose,
                      onLongPressStart: (details) => {longPressStart(details, index)},
                      child: Container(
                        padding:
                            EdgeInsets.only(left: 9, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment: (messages[index].messageType == "receiver"
                              ? Alignment.topLeft
                              : Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              // border: RoundedRectangleBorder(),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  bottomLeft:
                                      messages[index].messageType == "receiver"
                                          ? Radius.circular(0)
                                          : Radius.circular(20),
                                  bottomRight:
                                      messages[index].messageType == "receiver"
                                          ? Radius.circular(20)
                                          : Radius.circular(0)),
                              color: (messages[index].messageType == "receiver"
                                  ? Colors.grey[600]
                                  : Colors.grey[900]),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Text(
                              messages[index].text,
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal)),
                            ),
                          ),
                          
                        ),
                      ),
                      
                      ),);
              },
            ),
            
          ),
                 
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 8),
            height: 70,
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.photo_camera,
                    color: Colors.grey[800],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.keyboard_voice,
                    color: Colors.grey[800],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 0, top: 15, bottom: 15),
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade900,
                        filled: true,
                        hintText: 'message',
                        contentPadding: EdgeInsets.only(top: 10, left: 10),
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.emoji_emotions_outlined,
                              color: Colors.grey.shade600,
                            )),
                        hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.bold),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        // border: InputBorder.none
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
                (isSelected == true)?      
                      getReaction()
                      :Container(), 
              ],
            ),
          ),
          
        ]),
      ),
    );
  }

  getReaction() {
    return Transform(
        transform: Matrix4.translationValues((-180.0+(messages[indexPos].text).length), -550.0+(62*indexPos), 5),
        
        child: Padding(
                     padding: const EdgeInsets.only(bottom:25),
                     child: Container(
                        height:30,
                        width:150,
             
                       child:Container(
                                                              height: 28,
                                                                 width: 50,
                                                                    decoration: BoxDecoration(
                                                                         color: Colors.grey[900],
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10)),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              28,
                                                                          width:
                                                                              25,
                                                                                color: Colors.grey[900],
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {    
                                                                                
                                                                              });
                                                                            },
                                                                            child:
                                                                                Transform(
                                                                              transform: Matrix4.translationValues(
                                                                                  -3,
                                                                                  0,
                                                                                  0),
                                                                              child:
                                                                                  Image.asset("assets/wow.gif"),
                                                                            ),
                                                                          ),
                                                                        ),                                                                      Container(
                                                                                                                                                                 width: 25,
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                          
                                                                              setState(() {
                                                                          
                                                                              });
                                                                            },
                                                                            child:
                                                                                Transform(
                                                                              transform: Matrix4.translationValues(
                                                                                  -3,
                                                                                  0,
                                                                                  1),
                                                                              child:
                                                                                  Image.asset("assets/love.gif"),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                            height: 28,
                                                                                              width: 25,
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                
                                                                              });
                                                                            },
                                                                            child:
                                                                                Transform(
                                                                              transform: Matrix4.translationValues(
                                                                                  -2,
                                                                                  0,
                                                                                  1),
                                                                              child:
                                                                                  Image.asset("assets/haha.gif"),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                             height: 28,
                                                                                              width: 25,
                                                                          decoration: BoxDecoration(
                                                                              color:
                                                                                    Colors.grey[900],
                                                                              borderRadius: BorderRadius.circular(10)),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                            
                                                                            },
                                                                            child:
                                                                                Transform(
                                                                              transform: Matrix4.translationValues(
                                                                                  -6,
                                                                                  0,
                                                                                  3),
                                                                              child:
                                                                                  Image.asset('assets/angry.gif'),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                           
                                                                      ],
                                                                    ),
                                                                  )
                      ),
                   ));
  }

  longPressStart(LongPressStartDetails details, int index) {
    setState(() {
      isSelected= true;
      indexPos = index;
      print(indexPos);  
    });
    
  }
}
