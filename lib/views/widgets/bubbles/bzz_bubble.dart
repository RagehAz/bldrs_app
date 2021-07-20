import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/views/screens/h1_bz_card_screen.dart';
import 'package:bldrs/views/widgets/in_pyramids/profile/bz_grid.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

import 'in_pyramids_bubble.dart';

class BzzBubble extends StatelessWidget {
  final List<TinyBz> tinyBzz;
  final String title;
  final int numberOfColumns;
  final int numberOfRows;
  final Axis scrollDirection;
  final Function onTap;
  final double corners;

  BzzBubble({
    @required this.tinyBzz,
    this.title  = 'Businesses',
    this.numberOfColumns = 5,
    this.numberOfRows = 2,
    this.scrollDirection = Axis.horizontal,
    this.onTap,
    this.corners,
});

  @override
  Widget build(BuildContext context) {
    return InPyramidsBubble(
      bubbleColor: Colorz.White10,
      corners: corners,
      columnChildren: <Widget>[

        // --- Title
        Padding(
          padding: const EdgeInsets.only(bottom: Ratioz.appBarPadding, left: Ratioz.appBarMargin*2, right: Ratioz.appBarMargin*2),
          child: SuperVerse(
            verse: title,
            centered: false,
            maxLines: 2,
          ),
        ),

        BzGrid(
            gridZoneWidth: Scale.superBubbleClearWidth(context),
            tinyBzz: tinyBzz == null ? [] : tinyBzz,
            numberOfColumns: numberOfColumns,
            numberOfRows: numberOfRows,
            scrollDirection: scrollDirection,
            corners: corners == null ? null : corners - Ratioz.appBarMargin,
            itemOnTap: (bzID) {

              if (onTap == null) {
                Nav.goToNewScreen(context, BzCardScreen(bzID: bzID,));
              } else {
                onTap(bzID);
              }

            },
        ),

      ],
    );
  }
}
