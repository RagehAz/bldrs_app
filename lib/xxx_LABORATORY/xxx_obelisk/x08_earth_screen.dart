import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/zoomable_widget.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class EarthScreen extends StatefulWidget {
  @override
  EarthScreenState createState() => EarthScreenState();
}

class EarthScreenState extends State<EarthScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = Scale.superScreenWidth(context);
    double screenHeight = Scale.superScreenHeight(context);
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
            children: <Widget>[]
            // worldDots(screenWidth,)
            // countryDots(countryWidth, Flagz.egy),
          ),
        ),
      ),
    );
  }
}
