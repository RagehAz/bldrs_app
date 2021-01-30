import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/flyer/grids/flyers_grid.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class SingleCollectionScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    double _screenWidth = superScreenWidth(context);

    return MainLayout(
      appBarType: AppBarType.Main,
      pyramids: Iconz.PyramidsYellow,
      layoutWidget: FlyersGrid(
        // flyersData: getAllCoFlyers(),
        gridZoneWidth: _screenWidth,
        numberOfColumns: 2,
      ),
    );
  }
}