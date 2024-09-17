// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables,
import 'package:flutter/material.dart';
import 'package:kawaii_vision/screens/Welcome/components/banner_image.dart';
import 'package:kawaii_vision/screens/Welcome/components/tile_footer.dart';
import 'package:kawaii_vision/screens/Welcome/models/welcome_details_fetch.dart';
import 'package:kawaii_vision/screens/Welcome/models/ws.dart';
import 'package:kawaii_vision/screens/Welcome/components/styles.dart';

// For using Timer
import 'dart:async';

class WsScreen extends StatefulWidget {
  static const id = 'ws_screen';

  final List<Location> locations;
  // ignore: use_key_in_widget_constructors
  WsScreen(this.locations);

  @override
  State<WsScreen> createState() => _WsScreenState();
}

// So, _WsScreenState is a private class accessed/extends only by WsScreen
class _WsScreenState extends State<WsScreen> {

  bool _showListView = false;

  @override
  void initState(){
    super.initState();

    // Delay for 5 seconds before showing the ListView
    Timer(Duration(seconds: 2), () async {
      setState(() {
        _showListView = true;
      });
    });

  }

  Future<void> Refresh() async {
    // Simulate network or data processing delay
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _showListView = false;
    });

    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _showListView = true;
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Projects & Co.', style: Styles.navBarTitle,)),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons. menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Handle search button press
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // Handle notification button press
              },
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.grey[800],
          child: Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.favorite,
                  size: 20,
                ),
              ),
              // home page list tile
              ListTile(
                leading: Icon(Icons.headphones_outlined),
                title: Text("JustAudio"),
                onTap: () {
                  // pop drawer first
                  Navigator.pop(context);

                  // home button go to first-page
                  Navigator.pushNamed(context, '/zero_app');
                },
              ),
              // setting page list tile
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Yet to add"),
                onTap: () {
                  // pop drawer first
                  Navigator.pop(context);

                  // setting button go to second-page
                  Navigator.pushNamed(context, '/one_app');
                },
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          // key: _refreshIndicatorKey,  // Add a GlobalKey to trigger the RefreshIndicator
          onRefresh: Refresh,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Show progress bar for 5 sec and than ListView
              if (!_showListView) renderProgressBar(context),
              // Expanded(child: renderListView(context)),
              if (_showListView) Expanded(child: renderListView(context)),
            ],
          ),
        ),
      ),
    );
  }


  // Helper Method (Rendering Method)
  Widget renderProgressBar(BuildContext context){
    return LinearProgressIndicator(
      value: null,
      backgroundColor: Colors.white,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
    );
  }

  Widget renderListView(BuildContext context){
    return ListView.builder(
      itemCount: widget.locations.length,
      itemBuilder: _listViewItemBuilder,
    );
  }

  // ItemBuilder is a BuildContext which is a callBack.
  Widget _listViewItemBuilder(BuildContext context, int index) {
    var location = widget.locations[index];
    return GestureDetector(
      onTap: () => _navigateToWs(context, index),
      child: Container(
        height: 245,
        child: Stack(
          children: [
            BannerImage(url: location.url, height: 245),
            _tileFooter(location),
          ],
        )
      ),
    );
  }

  void _navigateToWs(BuildContext context, int locationID) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Ws(locationID),
        ));
  }


  Widget _tileFooter(Location location){
    final info = TileFooter(location: location, darkTheme: true);
    final overlay = Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: Styles.horizontalPaddingDefault),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
      child: info,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [overlay],
    );
  }

}
