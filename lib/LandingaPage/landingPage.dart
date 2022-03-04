import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life_app/LandingaPage/addas.dart';
import 'package:life_app/LandingaPage/friends.dart';
import 'package:life_app/Models/conversationsImage.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  PanelController _panelController = PanelController();
  late Animation animation;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;
  late ScrollController _scrollController;
  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 10;

  int _selectedIndex = 0;
  late TabController _tabController;

  late double _panelHeightClosed;
  late double start;
  late double end;
  late double increment;

  void bounce(Timer t) async {
    if (_panelHeightClosed < end) {
      setState(() {
        _panelHeightClosed += increment;
      });
    } else {
      t.cancel();
    }
  }

  void interpolate(double start, double end) {
    setState(() {
      increment = (end - start) / 60;
    });
  }

  List<Tab> tabs = [
    Tab(
      text: 'Friends',
    ),
    Tab(
      text: 'Addas',
    )
  ];

  List<ConversationsImages> conversationsImages = [
    ConversationsImages(
        name: 'John',
        messageText: 'Hello',
        imageURL: 'assets/group_6898.png',
        markAs: 'Receiver'),
    ConversationsImages(
        name: 'Adda Name',
        messageText: 'WhatsUp! Guys',
        imageURL: 'assets/group_6897.png',
        markAs: 'Sender'),
    ConversationsImages(
        name: 'Adda Name',
        messageText: 'WhatsUp! Guys',
        imageURL: 'assets/group_6896.png',
        markAs: 'Receiver'),
    ConversationsImages(
        name: 'Angella',
        messageText: 'Hello',
        imageURL: 'assets/group_6582.png',
        markAs: 'Sender')
  ];

  @override
  // ignore: must_call_super
  void initState() {
    _panelHeightClosed = 0;
    start = 0;
    end = 100;
    interpolate(start, end);
    Timer.periodic(
        const Duration(
          milliseconds: 13,
        ),
        bounce);

    _fabHeight = _initFabHeight;
    _tabController =
        TabController(length: tabs.length, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .80;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            SlidingUpPanel(
              maxHeight: _panelHeightOpen,
              minHeight: _panelHeightClosed,
                 parallaxEnabled: true,
              parallaxOffset: .5,
              body: _body(),
              panelBuilder: (sc) => _panel(sc),
              backdropEnabled: true,
              backdropTapClosesPanel: true,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0)),
              color: Color(0xff1A1A1A),
              controller: _panelController,
              onPanelSlide: (double ops) => setState(() {
                _fabHeight = ops * (_panelHeightOpen - _panelHeightClosed) +
                    _initFabHeight;
                print(_fabHeight);
              }),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            fixedColor: Colors.black,
            backgroundColor: Colors.black,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/home_smile.png',
                    scale: 1.4,
                  ),
                  label: 'Home',
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/carbon.png',
                    scale: 1.4,
                  ),
                  label: 'Calls',
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                icon: ElevatedButton(
                  onPressed: () {},
                  child: Image.asset(
                    'assets/emojione_monotone_game_die.png',
                    scale: 1.4,
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(2),
                      primary: Colors.amber.shade300),
                ),
                label: 'Calls',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  height: 15,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Container(),
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(), primary: Colors.amber.shade300
                        // padding: EdgeInsets.all(24),
                        ),
                  ),
                ),
                label: 'Messages',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    size: 25,
                  ),
                  label: 'Settings',
                  backgroundColor: Colors.black),
            ]),
      ),
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
            ),
          ),
          _fabHeight >= 400
              ? Padding(
                  padding:
                      EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 16),
                  child: SizedBox(
                    height: 45,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search friends ...",
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey.shade600,
                          size: 28,
                        ),
                        filled: true,
                        fillColor: Colors.black87,
                        contentPadding: EdgeInsets.all(8),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          TabBar(
            tabs: tabs,
            controller: _tabController,
            indicatorColor: Colors.transparent,
            labelColor: Color(0xfff5d977),
           unselectedLabelColor: Colors.white,
            labelStyle: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 14)),
          ),
          Expanded(
            child: TabBarView(
                controller: _tabController, children: [Friends(), Addas()]),
          )
        ],
      ),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  center: Alignment.topLeft,
                  colors: [Color(0xff470d3a), Color(0xff410b35), Colors.black],
                  radius: 0.7)),
          child: Stack(
            children: [
              Transform(
                transform: Matrix4.translationValues(0, -360, 0),
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff2f215c),
                          offset: const Offset(-0.6, -0.6),
                          blurRadius: 45),
                      BoxShadow(
                        color: Color(0xff2d1f58),
                        offset: const Offset(0.0, 0.0),
                        spreadRadius: 12.0,
                        blurRadius: 70.0,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 35),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: Transform(
                        transform: Matrix4.translationValues(-20, 0, 0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            'assets/icon_back.png',
                            scale: 1.5,
                          ),
                        ),
                      ),
                    ),
                    Transform(
                      transform: Matrix4.translationValues(-18, 0, 0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: TweenAnimationBuilder(
                          child: Text('Conversations',
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700))),
                          duration: Duration(seconds: 3),
                          tween: Tween<double>(begin: 0, end: 1),
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value as double,
                              child: Padding(
                                padding: EdgeInsets.only(top: value * 10),
                                child: child,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Transform(
                      transform: Matrix4.translationValues(-50, 0, 0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: TweenAnimationBuilder(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Image.asset(
                                'assets/chat_new.png',
                                scale: 1.6,
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(15),
                                  primary: Color(0xff77c6ff)),
                            ),
                            tween: Tween<double>(begin: 0, end: 1),
                            duration: Duration(seconds: 4),
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value as double,
                                child: Padding(
                                  padding: EdgeInsets.only(top: value * 10),
                                  child: child,
                                ),
                              );
                            }),
                      ),
                    ),
                    Expanded(
                      child: Transform(
                        transform: Matrix4.translationValues(
                            0, -(MediaQuery.of(context).size.height / 15), 0),
                        child: AnimationLimiter(
                          child: ListView.builder(
                              itemCount: conversationsImages.length,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: Duration(seconds: 3),
                                  // delay: Duration(milliseconds: 100),
                                  child: SlideAnimation(
                                    verticalOffset: 600,
                                    curve: Curves.decelerate,
                                    child: Align(
                                      alignment:
                                          (conversationsImages[index].markAs ==
                                                  "Receiver"
                                              ? Alignment.topLeft
                                              : Alignment.topRight),
                                      heightFactor: 0.46,
                                      child: Column(
                                        children: [
                                          Transform.scale(
                                              scale: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  1300,
                                              child: Image.asset(
                                                  conversationsImages[index]
                                                      .imageURL)),
                                          Transform(
                                            transform:
                                                Matrix4.translationValues(
                                                    0, -45, 0),
                                            child: Card(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    conversationsImages[index]
                                                        .messageText,
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                    )),
                                              ),
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16)),
                                            ),
                                          ),
                                          Transform(
                                            transform:
                                                Matrix4.translationValues(
                                                    0, -40, 0),
                                            child: Text(
                                                conversationsImages[index].name,
                                                style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(
                    MediaQuery.of(context).size.height / 25,
                    MediaQuery.of(context).size.height / 3,
                    0),
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(seconds: 7),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value as double,
                      child: child,
                    );
                  },
                  child: Container(
                    height: 15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.purple),
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(
                    MediaQuery.of(context).size.height / 6,
                    MediaQuery.of(context).size.height / 2.67,
                    0),
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(seconds: 7),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value as double,
                      child: child,
                    );
                  },
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                           shape: BoxShape.circle, color: Colors.blue.shade300),
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(
                    MediaQuery.of(context).size.height / 5.4,
                    MediaQuery.of(context).size.height / 2.59,
                    0),
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(seconds: 7),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value as double,
                      child: child,
                    );
                  },
                  child: Container(
                    height: 5,
                    decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.yellow.shade300),
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(
                    -(MediaQuery.of(context).size.height / 20.0),
                    MediaQuery.of(context).size.height / 2.45,
                    0),
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(seconds: 7),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value as double,
                      child: child,
                    );
                  },
                  child: Container(
                    height: 15,
                    decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue.shade100),
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(
                    -(MediaQuery.of(context).size.height / 5.9),
                    MediaQuery.of(context).size.height / 2.05,
                    0),
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(seconds: 5),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value as double,
                      child: child,
                    );
                  },
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                     shape: BoxShape.circle, color: Colors.blue.shade300),
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(
                    -(MediaQuery.of(context).size.height / 5.4),
                    MediaQuery.of(context).size.height / 1.97,
                    0),
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(seconds: 5),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value as double,
                      child: child,
                    );
                  },
                  child: Container(
                    height: 5,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.yellow.shade300),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex.toString());
    });
  }


}
