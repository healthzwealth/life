import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:life_app/Models/StickersModel.dart';
import 'package:life_app/Models/UploadImageModel.dart';
import 'package:life_app/Models/friendsModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'dart:typed_data' show Uint8List;

import 'package:life_app/providers/uploadDiagImageProvider.dart';
import 'package:provider/provider.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> with TickerProviderStateMixin {
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
          imageS3: awsImageList[i].imageS3));
    }
  }

  getImages() async {
    awsFlag = false;
    UploadImageProvider downloadIamgeProvider =
        Provider.of<UploadImageProvider>(context, listen: false);
    setState(() {});
    print('______________________________');
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
    Tab(
      text: 'Memotion',
    ),
    Tab(
      text: 'Sticker',
    ),
    Tab(
      text: 'GIF',
    ),
    Tab(
      text: 'emoji',
    )
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
        image: false,
        imageS3: null),
    FriendsModel(
        name: 'Ramanujan',
        text: 'Hello!',
        date: 'today',
        imageURL:
            "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg",
        messageCount: 2,
        messageType: "receiver",
        image: false,
        imageS3: null),
    FriendsModel(
        name: 'Ramanujan',
        text: 'Happy Birthday!',
        date: 'today',
        imageURL:
            "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg",
        messageCount: 2,
        messageType: "sender",
        image: false,
        imageS3: null),
    FriendsModel(
        name: 'Ramanujan',
        text: 'Thank you!',
        date: 'today',
        imageURL:
            "https://thewondrous.com/wp-content/uploads/2015/07/cute-profile-pictures.jpg",
        messageCount: 2,
        messageType: "receiver",
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
        image: false,
        imageS3: null),
  ];
  List< FriendsModel>  friendsModels=[];
  List<StickersModel> stickers = [
    StickersModel( image: 'assets/frame_1.png', messageType: 'receiver', name: 'ABB'),
    StickersModel( image: 'assets/frame_2.png', messageType: 'sender', name: 'ABB'),
    StickersModel( image: 'assets/frame_3.png', messageType: 'sender', name: 'ABB'),
    StickersModel( image: 'assets/frame_4.png', messageType: 'sender', name: 'ABB'),
    StickersModel( image: 'assets/frame_5.png', messageType: 'sender', name: 'ABB'),
    StickersModel( image: 'assets/frame_6.png', messageType: 'sender', name: 'ABB'),
    StickersModel( image: 'assets/frame_7.png', messageType: 'sender', name: 'ABB'),
    StickersModel( image: 'assets/frame_8.png', messageType: 'sender', name: 'ABB'),
  ];
  @override
  Widget build(BuildContext context) {
    postDiagUploadImageS3(UploadImageModel uploadImageModel) async {
      UploadImageProvider upload =
          Provider.of<UploadImageProvider>(context, listen: false);
      await upload.postDiagUploadImageS3(uploadImageModel).then(
            (value) {
              setState(() {
                friendsModels.addAll(messages);
                messages.removeRange(0, messages.length);
                friendsModels.add(FriendsModel(
                    name: 'Ranjith',
                    text: 'Hi!',
                    date: 'today',
                    imageURL:'' ,
                    messageCount: 2,
                    messageType: "sender",
                    image: true,
                    imageS3: uploadImageModel.imageS3
                ));
              });
              //   print(friendsModels[index].imageURL);
              messages.addAll(friendsModels);
              friendsModels.removeRange(0, friendsModels.length);
            },
          );
    }

    void setUploadImageModel() {
      if (selectedImage != null) {
        UploadImageModel uploadImageModel = new UploadImageModel();
        final File imageFile = File(selectedImage!.path);
        print(imageFile);
        uploadImageModel.imageFile = imageFile;
        uploadImageModel.fileNameS3 = "LifeApp_ ${DateTime.now().toLocal()}.jpg";
        Uint8List bytes = imageFile.readAsBytesSync();
        uploadImageModel.imageS3 = bytes  ;

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
        child: Column(children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
            //  physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return messages[index].name=='image' ? Container(
                  padding:
                  EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (messages[index].messageType == "receiver"
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                      // decoration: BoxDecoration(
                      //   // border: RoundedRectangleBorder(),
                      //   borderRadius: BorderRadius.only(
                      //       topRight: Radius.circular(20),
                      //       topLeft: Radius.circular(20),
                      //       bottomLeft:
                      //       messages[index].messageType == "receiver"
                      //           ? Radius.circular(0)
                      //           : Radius.circular(20),
                      //       bottomRight:
                      //       messages[index].messageType == "receiver"
                      //           ? Radius.circular(20)
                      //           : Radius.circular(0)),
                      //   color: (messages[index].messageType == "receiver"
                      //       ? Colors.grey[600]
                      //       : Colors.grey[900]),
                      // ),
                      padding: EdgeInsets.all(16),
                     child: Transform.scale(
                        scale: 1,
                        child: Image.asset(
                            messages[index].imageURL))
                    ),
                  ),
                ): Container(
                  padding:
                      EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
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
                                : messages[index].image == false
                                ? Radius.circular(0)
                                : Radius.circular(20)),
                        color: (messages[index].messageType == "receiver"
                            ? Colors.grey[600]
                            : Colors.grey[900]),
                      ),
                      padding: messages[index].image == false
                          ? EdgeInsets.all(16)
                          : EdgeInsets.all(0),
                      child: messages[index].image == false
                          ? Text(
                              messages[index].text,
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal)),
                            )
                          : messages[index].imageS3!=null ? ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.memory(
                                        messages[index].imageS3!,
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.fill,
                                      ),

                            ) : Container(),
                    ),
                  ),
                );
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
                    padding:
                        const EdgeInsets.only(left: 0, top: 15, bottom: 15,),
                    child: TextField(onChanged: (value) {
                                  text = value.toString();
                    },
                      controller: fieldText,
                      style: TextStyle(color: Colors.white),
                      onTap: () {
                                        if (count == 1) {
                                                      setState(() {
                                                            count=1;
                                                            _visible = false;
                                                            pressAttention=false;
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
                              print('clicked');
                              print(messages.length);
                             // textMessages.add(text.toString());
                              clearText();
                              setState(() {
                                friendsModels.addAll(messages);
                                messages.removeRange(0, messages.length);
                                friendsModels.add(FriendsModel(
                                    name: 'text',
                                    text: text.toString(),
                                    date: 'today',
                                    imageURL: '',
                                    messageCount: 2,
                                    messageType: "sender",
                                    image: false,
                                    imageS3: null
                                ));
                              });
                              //   print(friendsModels[index].imageURL);
                              messages.addAll(friendsModels);
                              friendsModels.removeRange(0, friendsModels.length);
                            },

                            icon: Icon(

                              Icons.send,

                              color: Colors.grey.shade600,

                            )),
                        // suffixIcon:  IconButton(
                        //   icon: Icon(Icons.emoji_emotions_sharp,
                        //     color: pressAttention ? Colors.white : Colors.yellow,
                        //     // color: Colors.grey
                        //   ),
                        //   onPressed: () {
                        //     if (count == 0) {
                        //       print("Im here");
                        //       setState(() {
                        //         count++;
                        //         _visible = true;
                        //         pressAttention=false;
                        //       });
                        //       print(_visible);
                        //       print(count);
                        //     }
                        //     else if (count >= 0) {
                        //       print("Im else");
                        //       setState(() {
                        //         count--;
                        //         _visible = false;
                        //         pressAttention=true;
                        //       });
                        //
                        //     }
                        //
                        //     // Navigator.of(context).push(PageRouteBuilder(
                        //     //     pageBuilder:(context,animation,_) {
                        //     //       return StickerKeyboard();
                        //     //
                        //     //     },opaque: false));
                        //   },
                        // ),
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
                //       Transform(
                //         transform: Matrix4.translationValues(0, -13, 0),
                Transform(transform: Matrix4.translationValues(0, 0, 0),
                  child: IconButton(
                    icon: Icon(
                      Icons.emoji_emotions_sharp,
                      color: pressAttention ? Colors.white : Colors.yellow,
                      // color: Colors.grey
                    ),
                    onPressed: () {
                      if (count == 0) {
                        print("Im here");
                        setState(() {
                          count=1;
                          _visible = true;
                          pressAttention = false;
                        });
                        print(_visible);
                        print(count);
                      } else if (count >= 0) {
                        print("Im else");
                        setState(() {
                          count=0;
                          _visible = false;
                          pressAttention = true;
                        });
                      }

                      // Navigator.of(context).push(PageRouteBuilder(
                      //     pageBuilder:(context,animation,_) {
                      //       return StickerKeyboard();
                      //
                      //     },opaque: false));
                    },
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   height: 80,
          //   decoration: BoxDecoration(
          //     color: Colors.grey[900],
          //   ),
          //   child: Row(
          //     children: <Widget>[
          //       Transform(
          //         transform: Matrix4.translationValues(0, -13, 0),
          //         child: InkWell(
          //           child: IconButton(
          //             icon: Icon(
          //               Icons.photo_camera,
          //               color: Colors.grey[800],
          //             ),
          //             onPressed: () {},
          //           ),
          //         ),
          //       ),
          //       Transform(
          //         transform: Matrix4.translationValues(0, -13, 0),
          //         child: InkWell(
          //           child: IconButton(
          //             icon: Icon(
          //               Icons.keyboard_voice,
          //               color: Colors.grey[800],
          //             ),
          //             onPressed: () {},
          //           ),
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(left: 15),
          //         child: TextField(
          //           decoration: InputDecoration(
          //               fillColor: Colors.grey[350],
          //               hintText: "message",
          //               border: InputBorder.none),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          _visible == false ? Container() :
          Padding(
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
                    labelStyle: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 14)),
                  ),
                  SizedBox(
                    height: 300.0,
                    child: TabBarView(
                        controller: _tabController,
                        children: [
                          Container(child: Text("")),
                          ListView.builder(
                            itemCount:stickers.length,
                             shrinkWrap: true,
                            padding: EdgeInsets.only(top: 0, bottom: 0),
                            //  physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return          Container(
                                height: _kKeyboardHeight,
                                child: Wrap(
                                  children: <Widget>[
                                    for (final sticker in stickers)
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            friendsModels.addAll(messages);
                                            messages.removeRange(0, messages.length);
                                            friendsModels.add(FriendsModel(
                                                name: 'image',
                                                text: 'Hi!',
                                                date: 'today',
                                                imageURL: sticker.image,
                                                messageCount: 2,
                                                messageType: "sender",
                                                image: false,
                                                imageS3: null
                                            ));
                                          });
                                       //   print(friendsModels[index].imageURL);
                                          messages.addAll(friendsModels);
                                          friendsModels.removeRange(0, friendsModels.length);
                                        },
                                        child: Container(
                                          width: itemWidth,
                                          height: itemHeight,
                                          // padding:
                                          //  EdgeInsets.only(left: 14, right: 14, top: 0, bottom: 0),
                                          child: Transform.scale(
                                              scale: 1,
                                              child: Image.asset(
                                                  sticker
                                                      .image)),
                                        ),
                                      )
                                  ],
                                ),
                              );
                            },
                          ) ,
                          Container(child: Text("")),
                          Container(child: Text("")
                          )]),
                  )],
                ),
            )),]
      ),
      ) );
  }
}
