import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/views/screens/s52_bz_card_screen.dart';
import 'package:bldrs/views/widgets/flyer/grids/flyers_grid.dart';
import 'package:bldrs/views/widgets/flyer/stacks/flyer_stack.dart';
import 'package:bldrs/views/widgets/in_pyramids/profile/bz_grid.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

import 'in_pyramids_bubble.dart';

class FlyersBubble extends StatelessWidget {
  final List<TinyFlyer> tinyFlyers;
  final double flyerSizeFactor;
  final String title;
  final int numberOfColumns;
  final int numberOfRows;
  final Axis scrollDirection;
  final Function onTap;
  final double bubbleWidth;

  FlyersBubble({
    @required this.tinyFlyers,
    this.title  = 'Flyers',
    this.numberOfColumns = 5,
    this.numberOfRows = 2,
    this.scrollDirection = Axis.horizontal,
    this.onTap,
    this.flyerSizeFactor = 0.3,
    this.bubbleWidth,
  });

  @override
  Widget build(BuildContext context) {
    return InPyramidsBubble(
      bubbleColor: Colorz.WhiteAir,
      title: title,
      titleColor: Colorz.White,
      bubbleWidth: bubbleWidth,
      columnChildren: <Widget>[

        FlyerStack(
          flyersType: null,
          flyerSizeFactor: flyerSizeFactor,
          title: null,
          tinyFlyers: tinyFlyers,
        ),

        // FlyersGrid(
        //   gridZoneWidth: superBubbleClearWidth(context),
        //   tinyFlyers: tinyFlyers ?? [],
        //   numberOfColumns: numberOfColumns,
        //   stratosphere: false,
        //   scrollable: true,
        //   scrollDirection: Axis.vertical,
        // )

        // BzGrid(
        //   gridZoneWidth: superBubbleClearWidth(context),
        //   tinyBzz: tinyBzz ?? [],
        //   numberOfColumns: numberOfColumns,
        //   numberOfRows: numberOfRows,
        //   scrollDirection: scrollDirection,
        //   itemOnTap: (bzID) {
        //
        //     if (onTap == null) {
        //       Nav.goToNewScreen(context, BzCardScreen(bzID: bzID,));
        //     } else {
        //       onTap(bzID);
        //     }
        //   },
        // ),

      ],
    );
  }
}
