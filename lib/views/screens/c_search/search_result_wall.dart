import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:flutter/material.dart';

class SearchResultWall extends StatelessWidget {
  final String thing;

  const SearchResultWall({
    this.thing,
    });

  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);

    return Container(
      width: _screenWidth,
      height: _screenHeight,
      color: Colorz.yellow10,
    );
  }
}
