import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/flyer/stacks/flyers_grid.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

/// TASK : if flyer is deleted from database, its ID will still remain in user's saved flyers
/// then we need to handle this situation


class SavedFlyersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    return MainLayout(
      appBarType: AppBarType.Basic,
      sky: Sky.Black,
      pageTitle: 'Chosen Flyers',
      pyramids: Iconz.PyramidzYellow,
      layoutWidget: Column(
        children: <Widget>[

          Stratosphere(),

          Container(
            width: screenWidth,
            height: 100,
            color: Colorz.Yellow255,
          ),

          Container(
            width: screenWidth,
            height: _screenHeight - 100 - Ratioz.stratosphere,
            color: Colorz.BloodTest,
            child: GoHomeOnMaxBounce(
              child: Scroller(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: <Widget>[

                    FlyersGrid(
                      gridZoneWidth: screenWidth,
                      numberOfColumns: 2,
                    ),

                    PyramidsHorizon(heightFactor: 5,),

                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
