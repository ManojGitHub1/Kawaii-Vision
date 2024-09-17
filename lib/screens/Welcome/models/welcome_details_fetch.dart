
import 'package:flutter/cupertino.dart';

class Location {

  final String name;
  final String url;
  final String urlDocs;
  final String Myname;
  final String Mydesc;
  final Widget projectPath;

  final List<LocationFact> facts;

  Location({required this.name, required this.url, required this.urlDocs, required this.Myname,
    required this.Mydesc, required this.projectPath, required this.facts});
}

class LocationFact {
  final String title;
  final String text;
  LocationFact({required this.title, required this.text});
}
