import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class EarthScreen extends StatefulWidget {

  @override
  EarthScreenState createState() => EarthScreenState();
}

class EarthScreenState extends State<EarthScreen> {



  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);
    double _countrySizeFactor = 1;

    return MainLayout(
      pageTitle: 'The Entire Fucking Planet',
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidsYellow,
      layoutWidget: Container(
        width: _screenWidth * _countrySizeFactor,
        height: _screenHeight * _countrySizeFactor,
        color: Colorz.BloodTest,
        alignment: Alignment.center,
        child: Stack(
            alignment: Alignment.center,
            children: <Widget>[]
          // worldDots(screenWidth,)
          // countryDots(countryWidth, Flagz.egy),
        ),
      ),
    );
  }
}
