// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    // Make status bar transparent
    systemNavigationBarColor: Colors.transparent,
    // Make navigation bar transparent
    systemNavigationBarDividerColor: Colors.transparent,
    // Make navigation bar divider transparent
    systemNavigationBarIconBrightness: Brightness.light,
    // Change icon brightness to match UI
    statusBarIconBrightness: Brightness.light, // Change status bar icon brightness to match UI
  ));

  runApp(MyApp());
}

