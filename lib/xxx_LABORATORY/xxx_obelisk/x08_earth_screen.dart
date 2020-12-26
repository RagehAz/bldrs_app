import 'package:bldrs/ambassadors/db_brain/locations_brain.dart';
import 'package:bldrs/view_brains/drafters/zoomable_widget.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/flagz.dart';
import 'package:flutter/material.dart';

class EarthScreen extends StatefulWidget {
  @override
  EarthScreenState createState() => EarthScreenState();
}

class EarthScreenState extends State<EarthScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double countrySizeFactor = 1;
    double countryWidth = screenWidth * countrySizeFactor;
    return MaterialApp(
      title: 'The Entire Fucking Planet',
      home: Scaffold(
        backgroundColor: Colorz.SkyDarkBlue,
          appBar: AppBar(
            title: const Text('The Entire Fucking Planet'),
          ),
          body: ZoomableWidget(

            child: Container(
              width: screenWidth * countrySizeFactor,
              height: screenHeight * countrySizeFactor,
              color: Colorz.BloodTest,
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children:
                    // worldDots(screenWidth,)
                    countryDots(countryWidth, Flagz.Egypt),
              ),
            ),
          )),
    );
  }
}
