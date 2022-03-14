import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:life_app/Models/friendsModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ChatsCopy extends StatefulWidget {
  const ChatsCopy({Key? key}) : super(key: key);

  @override
  _ChatsCopyState createState() => _ChatsCopyState();
}

class _ChatsCopyState extends State<ChatsCopy> {

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
            child: Chats(),
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
              );           },         ),        );      }          //----------
          ),
    );
  }
}
class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {

  bool isSelected = false;
  int indexSelected = 0;
  int indexPos = 0;
  double iconHeight=28.0;
  final ScrollController _controller = ScrollController();

  List<FriendsModel> messages = [
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
    FriendsModel(
        name: 'Ramanujan',
        text: 'Hello!',
        date: 'today',
        imageURL:
            "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg",
        messageCount: 2,
        messageType: "receiver",
        selectedIcons: "",
        reactionPanel: "all"),
    FriendsModel(
        name: 'Ramanujan',
        text: 'Happy Birthday!',
        date: 'today',
        imageURL:
            "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg",
        messageCount: 2,
        messageType: "sender",
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
        reactionPanel: "all"),
    FriendsModel(
        name: 'Ramanujan',
        text: 'Glad you remembered.',
        date: 'today',
        imageURL:
            "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg",
        messageCount: 2,
        messageType: "receiver",
        selectedIcons: "",
        reactionPanel: "all"),

        FriendsModel(
        name: 'Ramanujan',
        text: 'ok,So how are thing going?',
        date: 'today',
        imageURL:
            "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg",
        messageCount: 2,
        messageType: "sender",
        selectedIcons: "",
        reactionPanel: "all"),
          FriendsModel(
        name: 'Ramanujan',
        text: 'Going great. I won!',
        date: 'today',
        imageURL:
            "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg",
        messageCount: 2,
        messageType: "receiver",
        selectedIcons: "",
        reactionPanel: "all"),
  ];

  String imageName="";

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
               child: AnimationLimiter(
            child: ListView.builder(
              controller:_controller,
              scrollDirection: Axis.vertical,
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              //physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: Duration(milliseconds: 500),
                                  // delay: Duration(milliseconds: 100),
                                  child: SlideAnimation(
                                    verticalOffset: 700,
                                    // curve: es.easeOutQuint,
                                    curve: Curves.linearToEaseOut,
                                    // curve: Curves.decelerate,
                           
              child: Stack(
                  children: <Widget>[
                    Slidable(
                  key: const ValueKey(0),
                  closeOnScroll: true,
                  
                  startActionPane: ActionPane(
                    extentRatio: 1/4,
                    motion: const ScrollMotion(),
                  
                    children: const [
             
                      SlidableAction(
                          onPressed: null,
                          backgroundColor: Color(0x380074),
                          foregroundColor: Colors.grey,
                          icon: Icons.reply_outlined,
                          spacing: 0,
                        ),
              
                          ],
                  ),
                    child:GestureDetector(
                      //onLongPress: toggleSelection,
                      behavior: HitTestBehavior.translucent,
                      onTap: toggleSelectionClose,
                      onTapDown: (details) {
                        print(" ON TAP DOWN ::: "+ details.kind!.index.toString());
                      },
                      onLongPressStart: (details) => {longPressStart(details, index)},
                      child: Container(
                        padding:
                            EdgeInsets.only(left: 9, right: 14, top: 10, bottom: 20),
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
                            
                            child: Stack (
                            children: <Widget> [
                              Text(
                              messages[index].text,
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal)),
                            ),
                            (messages[index].selectedIcons!="")? Transform(
                                transform: (messages[index].messageType=="receiver")?Matrix4.translationValues(2.0, 40, 5):Matrix4.translationValues(0, 30, 5),
                                child:Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                              borderRadius:
                                  BorderRadius.circular(
                                      10)),
                              child:Image.asset(messages[index].selectedIcons, height: 15, width: 15))):Text(""),
                            (messages[index].messageType=="receiver")? Transform(
                                transform: Matrix4.translationValues(-55, 25, 5),
                                child:CircleAvatar(backgroundColor: Colors.white, maxRadius: 14,child
                                :Image(image: NetworkImage(messages[index].imageURL), height: 18, width: 18))):Text(""),
                             
                            ],

                          ), 
                          ),
                        ),
                      ),
                      
                      ),),
                      (isSelected == true && index==indexPos)?      
                                getReaction(messages[index])
                                :Text(""),  

                  ],),),);
              },
            ),
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
                  child: Stack(
                    //padding:
                    //    const EdgeInsets.only(left: 0, top: 15, bottom: 15),
                    children: <Widget>[
                      TextField(
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
                      onSubmitted: (value) {
                        updateMessageList(value);
                      },
                    ),
                    
                    
                    ]),
                    
                ),
                 
              ],
            ),
          ),
          
        ]),
      ),
    );
  }

  void toggleSelection() {
    setState(() {
      isSelected = true;
    });
  }
  void toggleSelectionClose() {
    print("ON TAP CALLED WHILE CLOSING");
    setState(() {
      isSelected = false;
    });
  }
  getReaction(FriendsModel friendsModel) {
   
    return Transform(
        transform: (friendsModel.messageType=="receiver")?Matrix4.translationValues(50, 55, 10):Matrix4.translationValues((MediaQuery.of(context).size.width)-220, 55, 10),
        
        child: Padding(
                     padding: EdgeInsets.only(bottom:2),
                     child: Container(
                        height:40,
                        width:200,
                        decoration: BoxDecoration(
                                color: Colors.grey[900],
                              borderRadius:
                                  BorderRadius.circular(
                                      40)),
                       child:Container(
                    height: 35,
                        width: 100,
                          
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceEvenly,
                            children: [
                              InkWell(
                                  onTap: () {
                                    setState(() {    
                                      imageName="assets/wow.gif";
                                      messages[indexPos].selectedIcons = imageName;
                                      print(imageName);
                                      toggleSelectionClose();
                                    });
                                  },
                                  child:
                                   Image.asset("assets/wow.gif", height: 28, width: 35),
                                  ),  InkWell(
                                  onTap: () {
                                    setState(() {
                                      imageName="assets/love.gif";
                                      messages[indexPos].selectedIcons = imageName;
                                      print(imageName);
                                      toggleSelectionClose();
                                    });
                                  },
                                  
                                child:Image.asset("assets/love.gif", height: 28, width: 35),
                              ),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      imageName="assets/haha.gif";
                                      messages[indexPos].selectedIcons = imageName;
                                      print(imageName);
                                      toggleSelectionClose();
                                    });
                                  },
                                    child:
                                        Image.asset("assets/haha.gif", height: 28, width: 35),
                              ),
                              InkWell(
                                  onTap:
                                      () {
                                        setState(() {    
                                          imageName="assets/angry.gif";
                                          messages[indexPos].selectedIcons = imageName;
                                          print(imageName);
                                          toggleSelectionClose();
                                      });
                                  },
                                  
                                child:
                                        Image.asset("assets/angry.gif", height: 28, width: 35),
  
                             ),
                              InkWell(
                                  onTap:
                                      () {
                                        setState(() {    
                                          imageName="assets/plus.png";
                                          messages[indexPos].selectedIcons = imageName;
                                          print(imageName);
                                          toggleSelectionClose();
                                      });
                                  },
                                  
                                child:
                                        Image.asset("assets/plus.png", height: 28, width: 35),
  
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

  String getImage() {
    return imageName;
  }

  void updateMessageList(String value) {
    int len = messages.length;
    FriendsModel friendsModel = new FriendsModel( date: '', imageURL: '', messageCount: len+1, messageType: 'sender', name: 'Ramanujam', selectedIcons: '', text: value, reactionPanel: 'all');
    setState(() {
      messages.add(friendsModel);  
        _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: Duration(seconds: 4),
        curve: Curves.fastOutSlowIn,
      );
    });
    
  }
}
