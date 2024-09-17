// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'styles.dart';
import '../models/welcome_details_fetch.dart';

const LocationTileHeight = 82.0;

class TileFooter extends StatelessWidget {
  final Location location;
  final bool darkTheme;

  TileFooter({required this.location, required this.darkTheme});

  @override
  Widget build(BuildContext context) {

    final title = location.name.toUpperCase();
    final My_name = location.Myname.toUpperCase();
    final My_desc = location.Mydesc.toUpperCase();

    return Container(
      padding: EdgeInsets.all(0.0),
      height: LocationTileHeight,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: this.darkTheme
                    ? Styles.locationTileTitleDark
                    : Styles.locationTileTitleLight),
            Text(My_name, style: Styles.locationTileMyName),
            Text(My_desc, style: Styles.locationTileMyDesc),

          ]),
    );
  }
}