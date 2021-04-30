import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/views/widgets/space/skies/night_sky.dart';
import 'package:flutter/material.dart';

class AppBarTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);

    return Scaffold(
      body: Container(
        width: _screenWidth,
        height: _screenHeight,
        child: NightSky(),
      ),
    );
  }
}
