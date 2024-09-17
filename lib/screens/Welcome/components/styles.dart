// ignore_for_file: prefer_const_declarations

import 'package:flutter/material.dart';

class Styles {
  static const _textSizeLarge = 22.0;
  static const _textSizeDefault = 20.0;
  static const _textSizeSmall = 15.0;
  static const _textWeightLarge = FontWeight.bold;

  static const horizontalPaddingDefault = 12.0;

  static final Color? _textColorStrong = Colors.grey[800];
  static final Color? _textColorDefault = Colors.grey[600];
  static final Color _textColorBright = Colors.white;
  static final Color accentColor = Colors.red;

  static final String _fontNameDefault = 'Montserrat';
  static final String _fontNameMyname = 'DancingScript';

  static final navBarTitle = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.w900,
    fontSize: _textSizeLarge,
    color: _textColorStrong
  );

  // ws page
  static final headerLarge = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: _textWeightLarge,
    fontSize: _textSizeLarge,
    color: _textColorStrong,
  );

  // ws page
  static final textDefault = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: _textWeightLarge,
    fontSize: _textSizeDefault,
    color: _textColorDefault,
  );

  // Theme Data Color in tile_footer
  static final locationTileTitleLight = TextStyle(
      fontFamily: _fontNameDefault,
      fontSize: _textSizeLarge,
      color: _textColorStrong
  );

  // Theme Data Color in tile_footer
  static final locationTileTitleDark = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeLarge,
    color: _textColorBright
  );

  // tile_footer page
  static final locationTileMyName = TextStyle(
    fontFamily: _fontNameMyname,
    fontSize: _textSizeDefault,
    fontWeight: _textWeightLarge,
    color: accentColor,
  );
  static final locationTileMyDesc = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeSmall,
    fontWeight: _textWeightLarge,
    color: _textColorDefault,
  );

}