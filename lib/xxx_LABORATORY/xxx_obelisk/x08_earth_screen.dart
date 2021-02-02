import 'package:bldrs/view_brains/controllers/locations_brain.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/zoomable_widget.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/flagz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class EarthScreen extends StatefulWidget {
  @override
  EarthScreenState createState() => EarthScreenState();
}

class EarthScreenState extends State<EarthScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = superScreenWidth(context);
    double screenHeight = superScreenHeight(context);
    double countrySizeFactor = 1;
    double countryWidth = screenWidth * countrySizeFactor;
    return MainLayout(
      pageTitle: 'The Entire Fucking Planet',
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidsYellow,
      layoutWidget: ZoomableWidget(

        child: Container(
          width: screenWidth * countrySizeFactor,
          height: screenHeight * countrySizeFactor,
          color: Colorz.BloodTest,
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: []
            // worldDots(screenWidth,)
            // countryDots(countryWidth, Flagz.egy),
          ),
        ),
      ),
    );
  }
}
