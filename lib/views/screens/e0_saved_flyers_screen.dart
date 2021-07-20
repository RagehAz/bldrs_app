import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/flyer/grids/flyers_grid.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

/// TASK : if flyer is deleted from database, its ID will still remain in user's saved flyers
/// then we need to handle this situation


class SavedFlyersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double screenWidth = Scale.superScreenWidth(context);

    return MainLayout(
      appBarType: AppBarType.Basic,
      sky: Sky.Black,
      pageTitle: 'Chosen Flyers',
      pyramids: Iconz.PyramidzYellow,
      layoutWidget: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[

          Stratosphere(),

          FlyersGrid(
            gridZoneWidth: screenWidth,
            numberOfColumns: 3,
          ),

          PyramidsHorizon(heightFactor: 5,),

        ],
      ),
    );
  }
}
