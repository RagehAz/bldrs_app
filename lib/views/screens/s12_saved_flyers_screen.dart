import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/views/widgets/flyer/grids/flyers_grid.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class SavedFlyersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double screenWidth = superScreenWidth(context);

    return MainLayout(
      appBarType: AppBarType.Basic,
      appBarBackButton: true,
      sky: Sky.Black,
      layoutWidget: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Stratosphere(),

            FlyersGrid(
              gridZoneWidth: screenWidth,
              numberOfColumns: 3,
            ),

            PyramidsHorizon(heightFactor: 5,),

          ],
        ),
      ),
    );
  }
}
