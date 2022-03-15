import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:life_app/LandingaPage/landingPage.dart';
import 'package:life_app/providers/uploadChatImageProvider.dart';
import 'package:provider/provider.dart';

import 'ModalBottomSheet/cupertino_bottom_sheet.dart';
import 'ModalBottomSheet/material_with_modal_page_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UploadImageProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return MaterialWithModalsPageRoute(
                  builder: (_) => HomePage(), settings: settings);
          }
          return MaterialPageRoute(
              builder: (context) => Scaffold(
                    body: CupertinoScaffold(
                      body: Builder(
                        builder: (context) => CupertinoPageScaffold(
                          backgroundColor: Colors.white,
                          navigationBar: CupertinoNavigationBar(
                            transitionBetweenRoutes: false,
                          ),
                          child: Center(child: Container()),
                        ),
                      ),
                    ),
                  ),
              settings: settings);
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
