// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kawaii_vision/screens/Welcome/components/banner_image.dart';
import 'package:kawaii_vision/screens/Welcome/models/welcome_details_fetch.dart';
import 'package:kawaii_vision/screens/Welcome/webview_screen.dart';
import '../mocks/welcome_details.dart';
import 'package:kawaii_vision/screens/Welcome/components/styles.dart';

class Ws extends StatefulWidget {

  static const id = 'ws';

  // final Location location;
  final int locationID;
  Ws(this.locationID, {super.key});

  @override
  State<Ws> createState() => _WsState();
}

class _WsState extends State<Ws> {

  bool _isDarkTheme = false;
  // Dynamic theme toggle
  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    var location = WelcomeDetails.fetch(widget.locationID);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // .copyWith to overwrite
      theme: _isDarkTheme ? ThemeData.dark().copyWith(scaffoldBackgroundColor: null) : ThemeData.light().copyWith(scaffoldBackgroundColor: null),
      home: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                location.name.toUpperCase(),
                  style: _isDarkTheme
                      ? Styles.locationTileTitleDark.copyWith(fontWeight: FontWeight.bold)
                      : Styles.locationTileTitleLight.copyWith(fontWeight: FontWeight.bold)
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black,),
              onPressed: () {
                Navigator.pop(context); // This will take the user back to the previous screen
              },
            ),
            actions: [
              IconButton(
                icon: Icon(_isDarkTheme ? Icons.dark_mode : Icons.light_mode),
                onPressed: _toggleTheme,
              ),
            ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Color(0x00000000)],
                  // colors: [Colors.lightBlueAccent, Colors.blue, Colors.lightBlueAccent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _renderBody(context, location),
                ),
                // Bottom button to go to project screen
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: _isDarkTheme? Colors.white : Colors.black87, // Shadow color
                                spreadRadius: 5, // Spread the shadow
                                blurRadius: 15, // Blur the shadow
                                offset: Offset(0, 2), // Control the position of the shadow
                              )
                            ]
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Colors.blue), // Button color
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0), // Rounded corners
                              ),
                            ),
                            padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),),
                            // Using boxShadow
                            // elevation: WidgetStateProperty.all(10.0),
                            // shadowColor: _isDarkTheme ? WidgetStateProperty.all(Colors.white) : WidgetStateProperty.all(Colors.black),
                          ),
                          onPressed: () {
                            // Navigator.pushNamed(context, Quizzler.id);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => location.projectPath,
                                ));
                          },
                          child: Text(
                            'Next',
                            style: Styles.textDefault,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }

  List<Widget> _renderBody(BuildContext context, Location location) {
    var result = <Widget>[];

    result.add(BannerImage(url: location.url, height: 300));
    // addAll return the list of Widget
    result.addAll(_renderFacts(context, location));
    return result;
  }

  List<Widget> _renderFacts(BuildContext context, Location location) {
    var result = <Widget>[];
    result.add(_sectionMyname(location, location.Myname, location.Mydesc));
    for (int i = 0; i < location.facts.length; i++) {
      result.add(_sectionTitle(location.facts[i].title));
      result.add(_sectionText(location.facts[i].text));
    }
    return result;
  }

  Widget _sectionMyname(Location location, String myname, String mydesc) {
    return Container(
      padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Button on left, myname on right
            children: [
              Text(
                myname,
                style: Styles.locationTileMyName,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[400],
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8.0,
                  shadowColor: _isDarkTheme ? Colors.white : Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebviewScreen(location.urlDocs),
                      )
                  );
                },
                child: Text(
                  'Docs',
                  style: Styles.textDefault,
                ),
              )
            ],
          ),
          SizedBox(height: 5.0), // Add space between myname and description
          Text(
            mydesc,
            style: Styles.locationTileMyDesc,
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Container(
        padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 10.0),
        child: Text(text,
            style: Styles.headerLarge,
        )
    );
  }

  Widget _sectionText(String text) {
    return Container(
        padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 10.0),
        child: Text(text,
          style: Styles.textDefault,
        )
    );
  }

}
