// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'Welcome/ws_screen.dart';

class HomeScreen extends StatefulWidget {

  static const id = 'home_screen';

  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // removes debug banner
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          surfaceTintColor: Colors.black,
          elevation: 20.0,
          shadowColor: Colors.red[700],
          title: Center(
            child: Text(
              'Welcome',
              style: TextStyle(
                fontFamily: 'Nosifer',
                fontSize: 25.0,
                color: Colors.red[800],
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80.0,
                backgroundImage: AssetImage('assets/images/anabella.jpg'),
              ),
              Text(
                'MANOJ JIVANAGI',
                style: TextStyle(
                  fontFamily: 'Nosifer',
                  fontSize: 30.0,
                  color: Colors.red[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigator.pushNamed(context, WelcomeScreen.id);
                  Navigator.pushNamed(context, WsScreen.id);
                },
                child: Text(
                  'FLUTTER DEVELOPER',
                  style: TextStyle(
                    fontFamily: 'Creepster',
                    fontSize: 30.0,
                    color: Colors.red[800],
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
                width: 150.0,
                child: Divider(
                  color: Colors.grey[400],
                ),
              ),
              Card(
                // card widget comes with default white color
                color: Colors.grey[800],
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    // size: 100.0,
                    // color: Colors.teal.shade900,
                    color: Colors.red[800],
                  ),
                  title: Text(
                    '+91 8767111956',
                    style: TextStyle(
                      color: Colors.red[800],
                      fontFamily: 'Creepster',
                      fontSize: 20.0,
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.grey[800],
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: ListTile(
                  leading: Icon(
                    Icons.mail_outline,
                    // size: 100.0,
                    // color: Colors.teal.shade900,
                    color: Colors.red[800],
                  ),
                  title: Text(
                    'manojjivanagi@yahoo.com',
                    style: TextStyle(
                      color: Colors.red[800],
                      fontFamily: 'Creepster',
                      fontSize: 20.0,
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ),
            ],
          ), // Or Row
        ),
      ),
    );
  }
}
