import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/views/screens/s52_bz_card_screen.dart';
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

  BzzBubble({
    @required this.tinyBzz,
    this.title  = 'Businesses',
    this.numberOfColumns = 5,
    this.numberOfRows = 2,
    this.scrollDirection = Axis.horizontal,
    this.onTap,
});

  @override
  Widget build(BuildContext context) {
    return InPyramidsBubble(
      bubbleColor: Colorz.WhiteAir,
      columnChildren: <Widget>[

        // --- Title
        Padding(
          padding: const EdgeInsets.only(bottom: Ratioz.ddAppBarPadding, left: Ratioz.ddAppBarMargin, right: Ratioz.ddAppBarMargin),
          child: SuperVerse(
            verse: title,
          ),
        ),

        BzGrid(
            gridZoneWidth: superBubbleClearWidth(context),
            tinyBzz: tinyBzz,
            numberOfColumns: numberOfColumns,
            numberOfRows: numberOfRows,
            scrollDirection: scrollDirection,
            itemOnTap: (bzID) {
              if (onTap == null) {
                goToNewScreen(context, BzCardScreen(bzID: bzID,));
              } else {
                onTap(bzID);
              }
            },
        ),

      ],
    );
  }
}
