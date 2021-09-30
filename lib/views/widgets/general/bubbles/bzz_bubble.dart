import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/views/screens/i_flyer/h_1_bz_card_screen.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/specific/in_pyramids/profile/bz_grid.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BzzBubble extends StatelessWidget {
  final List<TinyBz> tinyBzz;
  final String title;
  final int numberOfColumns;
  final int numberOfRows;
  final Axis scrollDirection;
  final Function onTap;
  final double corners;

  const BzzBubble({
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
    return Bubble(
      bubbleColor: Colorz.White10,
      corners: corners,
      columnChildren: <Widget>[

        /// --- Title
        Padding(
          padding: const EdgeInsets.only(bottom: Ratioz.appBarPadding, left: Ratioz.appBarMargin*2, right: Ratioz.appBarMargin*2),
          child: SuperVerse(
            verse: title,
            centered: false,
            maxLines: 2,
          ),
        ),

        BzGrid(
            gridZoneWidth: Bubble.clearWidth(context),
            tinyBzz: tinyBzz == null ? <TinyBz>[] : tinyBzz,
            numberOfColumns: numberOfColumns,
            numberOfRows: numberOfRows,
            scrollDirection: scrollDirection,
            corners: corners == null ? null : corners - Ratioz.appBarMargin,
            itemOnTap: (bzID) {

              if (onTap == null) {
                Nav.goToNewScreen(context, BzCardScreen(bzID: bzID, flyerBoxWidth: Bubble.clearWidth(context),));
              } else {
                onTap(bzID);
              }

            },
        ),

      ],
    );
  }
}
