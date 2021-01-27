import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/appbar/sliver_ab_main.dart';
import 'package:bldrs/views/widgets/flyer/grids/flyers_grid.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:bldrs/views/widgets/space/skies/night_sky.dart';
import 'package:flutter/material.dart';

class SingleCollectionScreen extends StatefulWidget {
  @override
  _SingleCollectionScreenState createState() => _SingleCollectionScreenState();
}

class _SingleCollectionScreenState extends State<SingleCollectionScreen> {
  String currentSection = 'Construction Products';
  bool sectionsListIsOn = false;

  void _chooseSection(String sectionName) {
    setState(() {
      currentSection = sectionName;
      sectionsListIsOn = false;
    });
    print(currentSection);
  }

  void openSectionsList() {
    print(sectionsListIsOn);
    setState(() {
      sectionsListIsOn == false
          ? sectionsListIsOn = true
          : sectionsListIsOn = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            NightSky(),
            CustomScrollView(
              slivers: <Widget>[

                SliverABMain(
                  // sections: _sections,
                  currentSection: currentSection,
                  selectingASection: _chooseSection,
                  sectionsListIsOpen: sectionsListIsOn,
                  openingTheList: openSectionsList,
                ),

                SliverList(
                  delegate: SliverChildListDelegate([
                    FlyersGrid(
                      // flyersData: getAllCoFlyers(),
                      gridZoneWidth: screenWidth,
                      numberOfColumns: 2,
                    ),
                    ]
                  ),
                ),

              ],
            ),
            Pyramids(
              whichPyramid: Iconz.PyramidsYellow,
            ),
          ],
        ),
      ),
    );
  }
}
