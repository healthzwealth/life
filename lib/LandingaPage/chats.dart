import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:life_app/Models/StickersModel.dart';
import 'package:life_app/Models/UploadImageModel.dart';
import 'package:life_app/Models/friendsModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life_app/providers/uploadChatImageProvider.dart';
import 'dart:io';
import 'dart:typed_data' show Uint8List;
import 'package:provider/provider.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> with TickerProviderStateMixin {
  bool isSelected = false;
  int indexSelected = 0;
  int indexPos = 0;
  double iconHeight = 28.0;
  final ScrollController _controller = ScrollController();

  bool awsFlag = true;
  late File imageFile = File('your initial file');
  final picker = ImagePicker();
  final ImagePicker _picker = ImagePicker();

  XFile? selectedImage;
  bool _visible = false;
  var count = 0;
  bool pressAttention = true;
  late String text;
  TabController? _tabController;
  final fieldText = TextEditingController();
  void initState() {
    getImages();
    setState(() {
      _visible = false;
      _tabController =
          TabController(length: tabs.length, vsync: this, initialIndex: 0);
    });
  }

  List awsImageList = [];
  void setMemberData(List awsImageList) {
    for (int i = 0; i < awsImageList.length; i++) {
      messages.add(FriendsModel(
        name: 'Ramanujan',
        text: '',
        date: 'today',
        imageURL:
            "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg",
        messageCount: 2,
        messageType: "sender",
        image: true,
        imageS3: awsImageList[i].imageS3,
        selectedIcons: "",
        reactionPanel: "all",
        visibility: true
      ));
    }
    setState(() {
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
      ); 
    });
  }

  getImages() async {
    awsFlag = false;
    UploadImageProvider downloadIamgeProvider =
        Provider.of<UploadImageProvider>(context, listen: false);
    setState(() {});
   
    await downloadIamgeProvider.getAllImages().then((values) {
      setState(() {
        awsImageList = values;
        if (awsImageList.length > 0) {
          setMemberData(awsImageList);
        }
      });
    });
  }

  List<Tab> tabs = [
    Tab( text: 'Memotion'),
    Tab( text: 'Sticker'),
    Tab( text: 'GIF'),
    Tab( text: 'Emoji')
  ];
  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  void clearText() {
    fieldText.clear();
  }

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
        reactionPanel: "all",
        image: false,
        imageS3: null,
        visibility: true),
    FriendsModel(
        name: 'Ramanujan',
        text: 'Hello!',
        date: 'today',
        imageURL:
            "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg",
        messageCount: 2,
        messageType: "receiver",
        selectedIcons: "",
        reactionPanel: "all",
        image: false,
        imageS3: null,
        visibility: true),
    FriendsModel(
        name: 'Ramanujan',
        text: 'Happy Birthday!',
        date: 'today',
        imageURL:
            "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg",
        messageCount: 2,
        messageType: "sender",
        selectedIcons: "",
        reactionPanel: "all",
        image: false,
        imageS3: null,
        visibility: true),
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
        imageS3: null,
        visibility: true),
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
        imageS3: null,
        visibility: true),
    FriendsModel(
        name: 'Ramanujan',
        text: 'ok,So how are thing going?',
        date: 'today',
        imageURL:
            "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg",
        messageCount: 2,
        messageType: "sender",
        selectedIcons: "",
        reactionPanel: "all",
        image: false,
        imageS3: null,
        visibility: true),
    FriendsModel(
        name: 'Ramanujan',
        text: 'Going great. I won!',
        date: 'today',
        imageURL:
            "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg",
        messageCount: 2,
        messageType: "receiver",
        selectedIcons: "",
        reactionPanel: "all",
        image: false,
        imageS3: null,
        visibility: true),
  ];
  List<FriendsModel> friendsModels = [];
  List<StickersModel> stickers = [
    StickersModel(
        image: 'assets/frame_1.png', messageType: 'receiver', name: 'ABB'),
    StickersModel(
        image: 'assets/frame_2.png', messageType: 'sender', name: 'ABB'),
    StickersModel(
        image: 'assets/frame_3.png', messageType: 'sender', name: 'ABB'),
    StickersModel(
        image: 'assets/frame_4.png', messageType: 'sender', name: 'ABB'),
    StickersModel(
        image: 'assets/frame_5.png', messageType: 'sender', name: 'ABB'),
    StickersModel(
        image: 'assets/frame_6.png', messageType: 'sender', name: 'ABB'),
    StickersModel(
        image: 'assets/frame_7.png', messageType: 'sender', name: 'ABB'),
    StickersModel(
        image: 'assets/frame_8.png', messageType: 'sender', name: 'ABB'),
  ];
  String imageName = "";
 Uint8List? imageS3;
  @override
  Widget build(BuildContext context) {

  //----------------------------ATTACH IMAGE  FUNCTION /UPLOADING IMAGE/OPEN IMAGE GALLERY---------------------------------------  
    postDiagUploadImageS3(UploadImageModel uploadImageModel) async {
      UploadImageProvider upload =
          Provider.of<UploadImageProvider>(context, listen: false);
      await upload.postUploadChatImageS3(uploadImageModel).then(
        (value) {
          setState(() {
            imageS3 = uploadImageModel.imageS3;
            FriendsModel friendsModel= new FriendsModel(
                name: 'Ranjith',
                text: 'Hi!',
                date: 'today',
                imageURL: '',
                messageCount: 2,
                messageType: "sender",
                image: true,
                imageS3: uploadImageModel.imageS3,
                selectedIcons: '',
                reactionPanel: '',
                visibility: true);
            messages.add(friendsModel);
            _controller.animateTo(
              _controller.position.maxScrollExtent+210,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOut,
            );
          });
        },
      );
    }

    void setUploadImageModel() {
      if (selectedImage != null) {
        UploadImageModel uploadImageModel = new UploadImageModel();
        final File imageFile = File(selectedImage!.path);
        print(imageFile);
        uploadImageModel.imageFile = imageFile;
        uploadImageModel.fileNameS3 =
            "LifeApp_ ${DateTime.now().toLocal()}.jpg";
        Uint8List bytes = imageFile.readAsBytesSync();
        uploadImageModel.imageS3 = bytes;

        postDiagUploadImageS3(uploadImageModel);

      } else {}
    }

    openGallery(BuildContext context) async {
      selectedImage = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 30);
      this.setState(() {
        setUploadImageModel();
      });
    }
//-----------------------------------------------------------------------------------------------------
    late AnimationController _appearanceController;
    _appearanceController = AnimationController(
      vsync: this,
    );
    const double _kKeyboardHeight = 350;
    final double rows = 2;
    final double screenWidth = MediaQuery.of(context).size.width;
    final int colorsCount = stickers.length;
    final int colorsPerRow = (colorsCount / rows).ceil();
    final double itemWidth = screenWidth / colorsPerRow;
    final double itemHeight = _kKeyboardHeight / 3;
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
        child: Column(
          children: <Widget>[
            Expanded(
              child: AnimationLimiter(
                child: ListView.builder(
                  controller: _controller,
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
                                extentRatio: 1 / 4,
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
                              child: GestureDetector(
                                //onLongPress: toggleSelection,
                                behavior: HitTestBehavior.translucent,
                                onTap: toggleSelectionClose,
                                onLongPressStart: (details) =>
                                    {
                                      longPressStart(details, index)},

                                child:  Container(
                                  padding: EdgeInsets.only(
                                      left: 9, right: 14, top: 10, bottom: 20),
                                  child: Align(
                                    alignment: (messages[index].messageType ==
                                            "receiver"
                                        ? Alignment.topLeft
                                        : Alignment.topRight),
//------------------------------IF NOT 'IMAGE MESSAGE' GO INSIDE CONTAINER----------------------------------------                                        
                                    child: messages[index].image == false
                                              ? AnimatedOpacity(
                                            opacity: messages[index].visibility?1.0:0.0,
                                            curve: Curves.linearToEaseOut,
                                            duration: const Duration(milliseconds: 500),
                                            child: Container(
                                                  decoration:  BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  topLeft: Radius.circular(20),
                                                  bottomLeft: messages[index]
                                                              .messageType ==
                                                          "receiver"
                                                      ? Radius.circular(0)
                                                      : Radius.circular(20),
                                                  bottomRight: messages[index]
                                                              .messageType ==
                                                          "receiver"
                                                      ? Radius.circular(20)
                                                      : Radius.circular(0)),
                                              color: (messages[index]
                                                          .messageType ==
                                                      "receiver"
                                                  ? Colors.grey[600]
                                                  : Colors.grey[900]),
                                            ),
                                      padding: EdgeInsets.all(16),

//---------------STACKING 'TEXT MESSAGE' WITH SELECTED 'EMOJI' AND ' RECEIVER'S IMAGE' (CIRCLE AVATAR - FOR SLIDABLE)-------------------------
                                      child: Stack(
                                        children: <Widget>[
                               //---------'TEXT MESSAGE'-------------------           
                                            Text(
                                                messages[index].text,
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.normal)),
                                            ), 
                                            
                                          (messages[index].selectedIcons != "")
                                              ? Transform(
                                                  transform: (messages[index].messageType ==
                                                          "receiver")
                                                      ? Matrix4.translationValues(
                                                          2.0, 40, 5)
                                                      : Matrix4.translationValues(
                                                          0, 30, 5),
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[900],
                                                          borderRadius: BorderRadius.circular(
                                                              10)),
                                   //----------'SELECTED EMOJI'------------------                           
                                                      child: Image.asset(
                                                          messages[index].selectedIcons,
                                                          height: 15,
                                                          width: 15)))
                                              : Text(""),
                                          (messages[index].messageType ==
                                                  "receiver")
                                              ? Transform(
                                                  transform:
                                                      Matrix4.translationValues(
                                                          -55, 25, 5),
                                                  child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      maxRadius: 14,
                                             //-------RECEIVER'S IMAGE IN SLIDABLE--------         
                                                      child: Image(
                                                          image: NetworkImage(
                                                              messages[index]
                                                                  .imageURL),
                                                          height: 18,
                                                          width: 18)))
                                              : Text(""),
                                        ],
                                      )  
                                    )):
 //--------------------------------- ELSE ---> DISPLAY IMAGES------------------------------------------------------                               
                                   Stack(
                                        children: <Widget>[
                                 (messages[index].name == 'image')
                                                  ? Transform(
                                                  transform: (messages[index].messageType ==
                                                          "sender")
                                                      ? Matrix4.translationValues(
                                                          0.0, 20, 5)
                                                      : Matrix4.translationValues(
                                                          0, 30, 5),
                                                  child: Image.asset(
                                                      messages[index].imageURL))
                                                  : messages[index].imageS3 !=
                                                          null
                                                      ? Transform(
                                                  transform: (messages[index].messageType ==
                                                          "sender")
                                                      ? Matrix4.translationValues(
                                                          0.0, 0, 5)
                                                      : Matrix4.translationValues(
                                                          0, 30, 5),
                                                  child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          child: Image.memory(
                                                            messages[index]
                                                                .imageS3!,
                                                            width: 220,
                                                            height: 220,
                                                            fit: BoxFit.fill
                                                          ),
                                                        ),)
                                                      : Text(""),   
                                              (messages[index].selectedIcons != "")
                                              ? Transform(
                                                  transform: (messages[index].messageType ==
                                                          "sender")
                                                      ? (messages[index].imageS3 != null)? Matrix4.translationValues(
                                                          0, 200, 10): 
                                                          Matrix4.translationValues(
                                                          2.0, 120,5 )
                                                      : Matrix4.translationValues(
                                                          0, 0,5 ),
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[900],
                                                          borderRadius: BorderRadius.circular(
                                                              10)),
                                   //----------'SELECTED EMOJI'----------------------------------                           
                                                      child: Image.asset(
                                                          messages[index].selectedIcons,
                                                          height: 18,
                                                          width: 15))):Text("") ]),
                                  ),

                                )
                              ),
                            ),
 //--------------------------ON LONGPRESS : DISPLAY EMOJIS LIST BAR---------------------------------------------                           
                            (isSelected == true && index == indexPos)
                                ? getReaction(messages[index])
                                : Text(""),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
 //----------------BOTTOM BAR ICONS AND TEXT INPUT BOX------------------------------------------------------------           
            Container(
                // padding: EdgeInsets.symmetric(horizontal: 8),
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        openGallery(context);
                      },
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
                        padding: const EdgeInsets.only(
                          left: 0,
                          top: 15,
                          bottom: 15,
                        ),
                        child: TextField(
                          onChanged: (value) {
                            text = value.toString();
                          },
                          controller: fieldText,
                          style: TextStyle(color: Colors.white),
                          onTap: () {
                            if (count == 1) {
                              setState(() {
                                count = 0;
                                _visible = false;
                                pressAttention = true;
                              });
                              print(_visible);
                              print(count);
                            }
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade900,
                            filled: true,
                            hintText: 'message',
                            contentPadding: EdgeInsets.only(top: 10, left: 10),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  print("PRESS : "+text.toString());
                                  
                                  setState(() {
                     //----------AUTO-SCROLL FOR TEXT-------
                                     updateMessageList(text.toString());
                                     
                                  });
                                  clearText();
                                  //   print(friendsModels[index].imageURL);
                                  // messages.addAll(friendsModels);
                                  // friendsModels.removeRange(
                                  //     0, friendsModels.length);
                                },
                                
                                icon: Icon(
                                  Icons.send,
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
                      ),
                    ),
  //------------------------ON-CLICK ICON TO OPEN STICKERS KEYBOARD ---------------------------------------------              
                    Transform(
                      transform: Matrix4.translationValues(0, 0, 0),
                      child: IconButton(
                        icon: Icon(
                          Icons.emoji_emotions_sharp,
                          color: pressAttention ? Colors.white : Colors.yellow,
                          // color: Colors.grey
                        ),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (count == 0) {
                            setState(() {
                              FocusScope.of(context).requestFocus(FocusNode());
                              count = 1;
                              _visible = true;
                              pressAttention = false;
                            });
                            print(_visible);
                            print(count);
                          } else if (count >= 0) {
                            setState(() {
                              count = 0;
                              _visible = false;
                              pressAttention = true;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                )),
//------------------------------STICKERS KEYBOARD-------------------------------------------------------
            _visible == false
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Container(
                      height: _kKeyboardHeight,
                      color: Colors.black,
                      child: Wrap(
                        children: <Widget>[
                          //  Text("Im here"),
                          TabBar(
                            tabs: tabs,
                            controller: _tabController,
                            indicatorColor: Colors.transparent,
                            labelColor: Color(0xfff5d977),
                            unselectedLabelColor: Color(0xff666666),
                            labelStyle: GoogleFonts.roboto(
                                textStyle: TextStyle(fontSize: 14)),
                          ),
                          SizedBox(
                            height: 300.0,
                            child: TabBarView(
                                controller: _tabController,
                                children: [
                                  Container(child: Text("")),
                                  ListView.builder(
                                    itemCount: 1,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(top: 0, bottom: 0),
                                    //  physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: _kKeyboardHeight,
                                        child: Wrap(
                                          children: <Widget>[
                                            for (final sticker in stickers)
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                               //------AUTO-SCROLL UP FOR STICKERS-----
                                                    updateMessageListWithSticker(sticker.image);
                                                    
                                                  });
                                                  // setState(() {
                                                  //   friendsModels
                                                  //       .addAll(messages);
                                                  //   messages.removeRange(
                                                  //       0, messages.length);
                                                  //   friendsModels
                                                  //       .add(FriendsModel(
                                                  //     name: 'image',
                                                  //     text: 'Hi!',
                                                  //     date: 'today',
                                                  //     imageURL: sticker.image,
                                                  //     messageCount: 2,
                                                  //     messageType: "sender",
                                                  //     image: true,
                                                  //     imageS3: null,
                                                  //     selectedIcons: "",
                                                  //     reactionPanel: "all",
                                                  //   ));
                                                  // });
                                                  // //   print(friendsModels[index].imageURL);
                                                  // messages
                                                  //     .addAll(friendsModels);
                                                  // friendsModels.removeRange(
                                                  //     0, friendsModels.length);
                                                },
                                                child: Container(
                                                  width: itemWidth,
                                                  height: itemHeight,
                                                  // padding:
                                                  //  EdgeInsets.only(left: 14, right: 14, top: 0, bottom: 0),
                                                  child: Transform.scale(
                                                      scale: 1,
                                                      child: Image.asset(
                                                          sticker.image)),
                                                ),
                                              )
                                          ],
                                        ),
                                      );
                                    },


                                  ),

                                  Container(child: Text("")),
                                  Container(child: Text("")),
                                ]),
                          )
                        ],
                      ),
                    )),
          ],
        ),
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
//------------------------EMOJI LIST DISPLAY FUNCTION-------------------------
  getReaction(FriendsModel friendsModel) {
    return Transform(
        transform: (friendsModel.messageType == "receiver")
            ? Matrix4.translationValues(50, 55, 10)
            : Matrix4.translationValues(
                (MediaQuery.of(context).size.width) - 220, 55, 10),
        child: Padding(
          padding: EdgeInsets.only(bottom: 2),
          child: Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(40)),
              child: Container(
                height: 35,
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          imageName = "assets/wow.gif";
                          messages[indexPos].selectedIcons = imageName;
                          print(imageName);
                          toggleSelectionClose();
                        });
                      },
                      child:
                          Image.asset("assets/wow.gif", height: 28, width: 35),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          imageName = "assets/love.gif";
                          messages[indexPos].selectedIcons = imageName;
                          print(imageName);
                          toggleSelectionClose();
                        });
                      },
                      child:
                          Image.asset("assets/love.gif", height: 28, width: 35),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          imageName = "assets/haha.gif";
                          messages[indexPos].selectedIcons = imageName;
                          print(imageName);
                          toggleSelectionClose();
                        });
                      },
                      child:
                          Image.asset("assets/haha.gif", height: 28, width: 35),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          imageName = "assets/angry.gif";
                          messages[indexPos].selectedIcons = imageName;
                          print(imageName);
                          toggleSelectionClose();
                        });
                      },
                      child: Image.asset("assets/angry.gif",
                          height: 28, width: 35),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          imageName = "assets/plus.png";
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
              )),
        ));
  }

  longPressStart(LongPressStartDetails details, int index) {
    setState(() {
      isSelected = true;
      indexPos = index;
      print(indexPos);
    });
  }

  String getImage() {
    return imageName;
  }

  void updateMessageList(String value) {
    int len = messages.length;
    print(value);
    FriendsModel friendsModel = new FriendsModel(
        date: '',
        imageURL: '',
        messageCount: len,
        messageType: 'sender',
        name: 'Ramanujam',
        selectedIcons: '',
        text: value,
        reactionPanel: 'all',
        image: false,
        imageS3: null,
        visibility: false);
    
    setState(() {
      messages.add(friendsModel);
      _controller.animateTo(
        _controller.position.maxScrollExtent+100,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInToLinear,   
      );
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          messages[messages.length-1].visibility = true;
        });
     });
    });
  }

  void updateMessageListWithSticker(String image) {
    int len = messages.length;
    FriendsModel friendsModel = new FriendsModel(
        date: "today",
        imageURL: image.trim(),
        messageCount: len+1,
        messageType: "sender",
        name: "image",
        selectedIcons: '',
        text: 'Hi',
        reactionPanel: 'all',
        image: true,
        imageS3: null,
        visibility: true);
    setState(() {
      messages.add(friendsModel);
      _controller.animateTo(
        _controller.position.maxScrollExtent+120,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }
}

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
              );
            },
          ),
        );
      } //----------

          ),
    );
  }
}
