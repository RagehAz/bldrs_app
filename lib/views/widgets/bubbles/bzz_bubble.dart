import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/screens/s51_sc_bz_card_screen.dart';
import 'package:bldrs/views/widgets/in_pyramids/profile/bz_grid.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

import 'in_pyramids_bubble.dart';

class BzzBubble extends StatelessWidget {
  final List<BzModel> bzz;

  BzzBubble({
    @required this.bzz,
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
            verse: 'Businesses',
          ),
        ),

        BzGrid(
            gridZoneWidth: superBubbleClearWidth(context),
            bzz: bzz,
            numberOfColumns: 5,
            numberOfRows: 2,
            scrollDirection: Axis.horizontal,
            itemOnTap: (bzID)=> goToNewScreen(context, BzCardScreen(bzID: bzID,))
        ),

      ],
    );
  }
}
