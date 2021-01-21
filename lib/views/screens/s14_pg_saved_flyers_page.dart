import 'package:bldrs/views/widgets/flyer/grids/flyers_grid.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart' show PyramidsHorizon;
import 'package:flutter/material.dart';

class SavedFlyersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    // double pageHeight = screenHeight - Ratioz.ddPyramidsHeight - Ratioz.ddPyramidsHeight;
    // double pageMargin = Ratioz.ddAppBarMargin * 2;

    return SliverList(
      delegate: SliverChildListDelegate([

        // // --- SAVED FLYERS BOX
        // SavedCollection(
        //   collectionFlyers: dummyCollection,
        //   collectionName: 'Appliance',
        //   keyWords: ['Fridge', 'Washing Machine', 'Stove', 'MicroWave'],
        // ),

        FlyersGrid(
          // flyersData: getAllCoFlyers(),
          gridZoneWidth: screenWidth,
          numberOfColumns: 3,
        ),

              // --- Pyramids scroll safe area
        PyramidsHorizon(),

      ]),
    );
  }
}
