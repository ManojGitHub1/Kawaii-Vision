// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:kawaii_vision/project_screens/Quizzler/quizzler.dart';
import 'package:kawaii_vision/project_screens/image_picker_display.dart';
import 'package:kawaii_vision/project_screens/live_camera_feed.dart';
import 'package:kawaii_vision/screens/Welcome/mocks/welcome_details.dart';
import 'package:kawaii_vision/screens/Welcome/models/ws.dart';
import 'package:kawaii_vision/screens/Welcome/models/welcome_details_fetch.dart';
import 'package:kawaii_vision/screens/Welcome/ws_screen.dart';
import 'package:kawaii_vision/screens/home_screen.dart';


class MyApp extends StatefulWidget {

  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final Location WDSingle = WelcomeDetails.fetchAny();

  final List<Location> WDAll = WelcomeDetails.fetchAll();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),

        Ws.id: (context) => Ws(WDSingle as int),
        // Ws.id: (context) => Ws(WelcomeDetails.fetchAny() as int),
        WsScreen.id: (context) => WsScreen(WDAll),
        // WsScreen.id: (context) => WsScreen(WelcomeDetails.fetchAll()),

        ImagePickerDisplay.id: (context) => ImagePickerDisplay(),
        LiveCameraFeed.id: (context) => LiveCameraFeed(),
        Quizzler.id: (context) => Quizzler(),
      },
    );
  }
}

