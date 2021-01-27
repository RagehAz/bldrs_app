import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/views/widgets/flyer/grids/flyers_grid.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart' show PyramidsHorizon;
import 'package:flutter/material.dart';

class SavedFlyersPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    double screenWidth = superScreenWidth(context);

    return SliverList(
      delegate: SliverChildListDelegate([

        FlyersGrid(
          gridZoneWidth: screenWidth,
          numberOfColumns: 3,
        ),

        PyramidsHorizon(),

      ]),
    );
  }
}
