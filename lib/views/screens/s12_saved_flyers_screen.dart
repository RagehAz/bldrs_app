import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/views/widgets/flyer/grids/flyers_grid.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class SavedFlyersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double screenWidth = superScreenWidth(context);

    return MainLayout(
      layoutWidget: FlyersGrid(
        gridZoneWidth: screenWidth,
        numberOfColumns: 3,
      ),
    );
  }
}
